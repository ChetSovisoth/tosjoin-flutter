import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fuzzy/fuzzy.dart'; // Added for fuzzy search
import 'package:tosjoin/service/cloudflarr2.dart'; // Import CloudflareR2Service
import 'package:tosjoin/pages/profile/profile_model.dart';
import 'package:tosjoin/service/enum.dart';
import 'package:tosjoin/service/storage_service.dart';

class HomeEvent {
  final int id;
  final String title;
  final String timing;
  final DateTime date;
  final String location;
  final String attached;
  final List<String> descriptions;

  HomeEvent({
    required this.id,
    required this.title,
    required this.timing,
    required this.date,
    required this.location,
    required this.attached,
    required this.descriptions,
  });

  factory HomeEvent.fromJson(Map<String, dynamic> json) {
    final id =
        json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0;

    return HomeEvent(
      id: id,
      title: json['title'] ?? "No Title",
      timing: json['timing']?.toString() ?? "No Timing",
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      location: json['location']?.toString() ?? "No location",
      attached: json['attached'] ?? "",
      descriptions: json['descriptions'] != null
          ? List<String>.from(json['descriptions'])
          : [
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
            ],
    );
  }

  Future<String> getImageUrl(CloudflareR2Service r2Service) async {
    return r2Service.getImageUrl(attached);
  }
}

class HomeController extends GetxController {
  var searchQuery = ''.obs;
  final profile = Rx<ProfileModel>(
      ProfileModel(username: 'NAN', role: UserRole.user, profile: ''));
  final isLoading = RxBool(true);
  final storage = Get.find<StorageService>();

  var categories = [
    {'name': 'Technology', 'icon': "lib/assets/technology.png"},
    {'name': 'AI', 'icon': "lib/assets/ai.png"},
    {'name': 'Data Science', 'icon': "lib/assets/datascient.png"},
    {'name': '3D', 'icon': "lib/assets/3d.png"},
    {'name': 'Mobile', 'icon': "lib/assets/mobiledev.png"},
    {'name': 'Cyber Security', 'icon': "lib/assets/security.png"},
  ].obs;

  var upcomingEvents = <Map<String, dynamic>>[].obs;
  var justAnnouncedEvents = <Map<String, dynamic>>[].obs;

  final CloudflareR2Service _cloudflareService = CloudflareR2Service();

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
    getProfile();
  }

  void joinEvent(String eventTitle) {
    print("Joined $eventTitle");
  }

  List<Map<String, dynamic>> searchEvents(String query) {
    if (query.isEmpty) {
      return [];
    }

    final allEvents = [...upcomingEvents, ...justAnnouncedEvents];
    final fuse = Fuzzy(
      allEvents,
      options: FuzzyOptions(
        keys: [
          WeightedKey(
            getter: (event) {
              // Cast event to Map<String, dynamic> and handle null case
              final eventMap = event as Map<String, dynamic>?;
              return eventMap?['title'] ?? '';
            },
            weight: 0.5,
            name: 'title',
          ),
          WeightedKey(
            getter: (event) {
              // Cast event to Map<String, dynamic> and handle null case
              final eventMap = event as Map<String, dynamic>?;
              return eventMap?['location'] ?? '';
            },
            weight: 0.5,
            name: 'location',
          ),
        ],
        threshold: 0.3, // Adjust the threshold as needed
      ),
    );

    final result = fuse.search(query);
    return result.map((r) => r.item as Map<String, dynamic>).toList();
  }

  Future<void> getProfile() async {
    isLoading(true); // Set loading state to true
    try {
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
          'https://tosjoin-367404119922.asia-southeast1.run.app/MobileUser/MyProfile');

      final response = await GetConnect().get(
        url.toString(),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 && response.body != null) {
        profile.value = ProfileModel.fromJson(response.body);
        await storage.setProfile(profile.value.toJson());
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch profile data: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
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

        for (var item in data) {
          final eventDate = DateTime.parse(item['date']);
          final event = {
            'id': item['id'].toString(),
            'date': item['date'],
            'title': item['title'],
            'location': item['location'],
            'attached': item['attached'],
          };

          if (eventDate.isAfter(fourteenDaysFromNow)) {
            upcomingEvents.add(event);
          } else if (eventDate.isAfter(today) ||
              eventDate.isAtSameMomentAs(today)) {
            justAnnouncedEvents.add(event);
          }
        }
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
