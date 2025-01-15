import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tosjoin/service/cloudflarr2.dart';
import 'dart:convert';
import 'package:tosjoin/pages/home/home_controller.dart'; // Import HomeEvent

class EventDetailController extends GetxController {
  var eventDetailTitle = "".obs;
  var location = "".obs;
  var date = "".obs;
  var timing = "".obs;
  var attendance = "0".obs; // Initialize attendance count as "0"
  var descriptions = <String>[].obs;
  var image = "".obs; // Default image

  final CloudflareR2Service _cloudflareService = CloudflareR2Service();
  final _storage = GetStorage(); // Initialize GetStorage

  Future<void> fetchEventDetails(String eventId) async {
    final url =
        'https://tosjoin-367404119922.asia-southeast1.run.app/UserEvent/$eventId';
    final token = await _getToken();

    if (token == null) {
      Get.snackbar(
        'Error',
        'Unauthorized: Please log in again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    try {
      debugPrint('Fetching event details from: $url');
      debugPrint('Headers: $headers');

      final response = await http.get(Uri.parse(url), headers: headers);
      debugPrint('Response status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        debugPrint('Parsed data: $data');

        // Use HomeEvent.fromJson to parse the event data
        final HomeEvent event = HomeEvent.fromJson(data);

        // Update the observable variables with the parsed event data
        eventDetailTitle.value = event.title;
        location.value = event.location ?? "No Location";
        date.value = event.date.toIso8601String();
        timing.value = event.timing;
        descriptions.value = event.descriptions;

        // Fetch attendance count from local storage
        final storedAttendance = _storage.read('attendance_$eventId') ?? "0";
        attendance.value = storedAttendance;

        // Use CloudflareR2Service to generate the image URL
        if (event.attached != null && event.attached.isNotEmpty) {
          final imageUrl = await _cloudflareService.getImageUrl(event.attached);
          debugPrint('Generated image URL: $imageUrl');
          image.value = imageUrl;
        } else {
          image.value = "lib/assets/logo.png"; // Fallback image
        }
      } else if (response.statusCode == 401) {
        Get.snackbar(
          'Error',
          'Unauthorized: Please log in again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (response.statusCode == 404) {
        Get.snackbar(
          'Error',
          'Event not found.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (response.statusCode == 500) {
        Get.snackbar(
          'Error',
          'Server error. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        throw Exception('Failed to load event details: ${response.statusCode}');
      }
    } catch (e) {
      // Debug: Print the error
      debugPrint('Error fetching event details: $e');

      Get.snackbar(
        'Error',
        'Failed to fetch event details. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
      );

      throw Exception('Error fetching event details: $e');
    }
  }

  // Update attendance count in local storage
  void updateAttendance(String eventId, int newAttendance) {
    attendance.value = newAttendance.toString();
    _storage.write('attendance_$eventId', attendance.value);
  }

  // Retrieve the access token from GetStorage
  Future<String?> _getToken() async {
    final box = GetStorage();
    return box.read('accessToken');
  }
}
