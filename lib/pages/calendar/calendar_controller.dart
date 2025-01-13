import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tosjoin/service/cloudflarr2.dart';

class CalendarEvent {
  final int id;
  final String title;
  final DateTime date;
  final String attached;

  CalendarEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.attached,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      attached: json['attached'] ?? "",
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
