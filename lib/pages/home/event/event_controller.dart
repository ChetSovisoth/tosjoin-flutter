import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tosjoin/service/cloudflarr2.dart';
import 'dart:convert';

class EventDetailController extends GetxController {
  var eventDetailTitle = "".obs;
  var location = "".obs;
  var date = "".obs;
  var timing = "".obs;
  var attendance = "".obs;
  var descriptions = <String>[].obs;
  var image = "lib/assets/logo.png".obs; // Default image

  final CloudflareR2Service _cloudflareService =
      CloudflareR2Service(); // Initialize CloudflareR2Service

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
      // Debug: Print the URL and headers
      debugPrint('Fetching event details from: $url');
      debugPrint('Headers: $headers');

      final response = await http.get(Uri.parse(url), headers: headers);

      // Debug: Print the response status code and body
      debugPrint('Response status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Debug: Print the parsed data
        debugPrint('Parsed data: $data');

        // Update the observable variables with API data
        eventDetailTitle.value = data['title'] ?? "No Title";
        location.value = data['location'] ?? "No Location";
        date.value = data['date'] ?? "No Date";
        timing.value = data['timing'] ?? "No Timing";
        attendance.value = data['attendance'] ?? "No Attendance";
        descriptions.value = data['description'] != null
            ? [data['description']] // Convert description to a list
            : ["No Description"];

        // Use CloudflareR2Service to generate the image URL
        if (data['attached'] != null) {
          final imageUrl = _cloudflareService.getImageUrl(data['attached']);
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

  // Retrieve the access token from GetStorage
  Future<String?> _getToken() async {
    final box = GetStorage();
    return box.read('accessToken');
  }
}
