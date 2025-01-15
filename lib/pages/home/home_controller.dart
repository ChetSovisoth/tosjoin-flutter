import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tosjoin/service/cloudflarr2.dart'; // Import CloudflareR2Service
import 'package:tosjoin/pages/profile/profile_model.dart';
import 'package:tosjoin/service/enum.dart';
import 'package:tosjoin/service/storage_service.dart';

class HomeEvent {
  final int id;
  final String title;
  final String timing;
  final DateTime date;
  final String attached;
  final List<String> descriptions; // Add descriptions field

  HomeEvent({
    required this.id,
    required this.title,
    required this.timing,
    required this.date,
    required this.attached,
    required this.descriptions, // Add to constructor
  });

  factory HomeEvent.fromJson(Map<String, dynamic> json) {
    return HomeEvent(
      id: int.parse(json['id'].toString()),
      title: json['title'],
      timing: json['timing'].toString(),
      date: DateTime.parse(json['date']),
      attached: json['attached'] ?? "",
      descriptions: json['descriptions'] ??
          [
            // Mock description data
            "Faculty of Engineering Party: Ignite, Innovate, Connect! Join us for a memorable event:",
            "- Welcome Session: Meet faculty, kick-start your journey.",
            "- Ice-Breaker Activities: Have fun, make friends.",
            "- Program Introductions: Explore engineering opportunities.",
            "- Innovation Workshops: Hands-on creativity sessions.",
            "- Student Clubs Showcase: Find your community.",
            "- Faculty Tour: Know your academic home.",
            "- Networking Lunch: Connect with faculty and peers.",
            "- Alumni Panel: Gain insights from successful graduates.",
            "- Closing Celebration: Wrap up with inspiration.",
            "- Set the stage for a year of growth, innovation, and excellence!",
          ], // Parse descriptions
    );
  }

  Future<String> getImageUrl(CloudflareR2Service r2Service) async {
    return r2Service.getImageUrl(attached);
  }
}

class HomeController extends GetxController {
  final profile = Rx<ProfileModel>(
      ProfileModel(username: 'NAN', role: UserRole.user, profile: ''));
  final isLoading = RxBool(true);
  final storage = Get.find<StorageService>();

  var categories = [
    {
      'name': 'Technology',
      'icon': "lib/assets/technology.png",
    },
    {'name': 'AI', 'icon': "lib/assets/ai.png"},
    {'name': 'Data Science', 'icon': "lib/assets/datascient.png"},
    {'name': '3D', 'icon': "lib/assets/3d.png"},
    {'name': 'Mobile', 'icon': "lib/assets/mobiledev.png"},
    {'name': 'Cyber Security', 'icon': "lib/assets/security.png"},
  ].obs;

  var upcomingEvents =
      <Map<String, dynamic>>[].obs; // Updated to fetch from API
  var justAnnouncedEvents =
      <Map<String, dynamic>>[].obs; // Updated to fetch from API

  final CloudflareR2Service _cloudflareService =
      CloudflareR2Service(); // Initialize CloudflareR2Service

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
    getProfile();
  }

  void joinEvent(String eventTitle) {
    print("Joined $eventTitle");
  }

  Future<void> getProfile() async {
    isLoading(true); // Set loading state to true
    try {
      // Retrieve the access token from storage
      final token = await _getToken();

      if (token == null) {
        Get.snackbar(
          'Error',
          'Unauthorized: Please log in again.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Define the API endpoint
      final url = Uri.parse(
          'https://tosjoin-367404119922.asia-southeast1.run.app/MobileUser/MyProfile');

      // Make the GET request with authorization header
      final response = await GetConnect().get(
        url.toString(),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200 && response.body != null) {
        // Parse the response body into a ProfileModel object
        profile.value = ProfileModel.fromJson(response.body);

        // Save the profile data to local storage
        await storage.setProfile(profile.value.toJson());
      } else {
        // Handle non-200 status codes
        Get.snackbar(
          'Error',
          'Failed to fetch profile data: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false); // Set loading state to false
    }
  }

  Future<void> fetchEvents() async {
    final token = await _getToken();

    if (token == null) {
      Get.snackbar(
        'Error',
        'Unauthorized: Please log in again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final url = Uri.parse(
        'https://tosjoin-367404119922.asia-southeast1.run.app/UserEvent');

    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        url.replace(queryParameters: {
          'startDate': DateTime.now().toIso8601String(),
          'endDate': DateTime.now()
              .add(Duration(days: 365))
              .toIso8601String(), // Fetch events for the next year
        }),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        upcomingEvents.clear();
        justAnnouncedEvents.clear();

        final today = DateTime.now();
        final fourteenDaysFromNow = today.add(Duration(days: 14));

        // Debug logs
        print('Today: $today');
        print('14 Days from Now: $fourteenDaysFromNow');

        for (var item in data) {
          final eventDate = DateTime.parse(item['date']);
          final event = {
            'id': item['id'].toString(),
            'date': item['date'],
            'title': item['title'],
            'location': item['location'],
            'attached': item['attached'],
          };

          // Debug log for event date
          print('Event Date: $eventDate');

          if (eventDate.isAfter(fourteenDaysFromNow)) {
            // Event is more than 14 days away (Upcoming Event)
            upcomingEvents.add(event);
          } else if (eventDate.isAfter(today) ||
              eventDate.isAtSameMomentAs(today)) {
            // Event is within 14 days or happening today (Just Announced Event)
            justAnnouncedEvents.add(event);
          }
        }

        print('Upcoming Events: ${upcomingEvents.length}');
        print('Just Announced Events: ${justAnnouncedEvents.length}');
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch events: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while fetching events: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<String?> _getToken() async {
    final box = GetStorage();
    return box.read('accessToken');
  }
}
