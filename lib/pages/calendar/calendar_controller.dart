import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tosjoin/service/cloudflarr2.dart';

class CalendarEvent {
  final int id;
  final String title;
  final String timing;
  final DateTime date;
  final String attached;
  final List<String> descriptions; // Add descriptions field

  CalendarEvent({
    required this.id,
    required this.title,
    required this.timing,
    required this.date,
    required this.attached,
    required this.descriptions, // Add to constructor
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      id: json['id'],
      title: json['title'],
      timing: json['timing'],
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

class CalendarController extends ChangeNotifier {
  final Map<DateTime, List<CalendarEvent>> events = {};
  final CloudflareR2Service cloudflareService = CloudflareR2Service();
  bool _isFetching = false;

  List<CalendarEvent> getEventsForDay(DateTime day) {
    return events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  Future<void> fetchEventsFromBackend(
      DateTime startDate, DateTime endDate) async {
    if (_isFetching) return;

    _isFetching = true;
    final url = Uri.parse(
        'https://tosjoin-367404119922.asia-southeast1.run.app/UserEvent');
    final token = await _getToken();

    if (token == null) {
      debugPrint('Error: No access token found.');
      _isFetching = false;
      return;
    }

    try {
      final response = await http.get(
        url.replace(queryParameters: {
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
        }),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        events.clear();

        for (var item in data) {
          final event = CalendarEvent.fromJson(item);
          final eventDate =
              DateTime(event.date.year, event.date.month, event.date.day);

          if (!events.containsKey(eventDate)) {
            events[eventDate] = [];
          }
          events[eventDate]!.add(event);
        }

        notifyListeners();
      } else {
        debugPrint('Failed to load events: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error fetching events: $e');
    } finally {
      _isFetching = false;
    }
  }

  Future<String?> _getToken() async {
    final box = GetStorage();
    return box.read('accessToken');
  }
}
