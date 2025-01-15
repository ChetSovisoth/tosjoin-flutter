import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CalendarEvent {
  final String title;
  final DateTime date;

  CalendarEvent({required this.title, required this.date});

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      title: json['title'],
      date: DateTime.parse(json['date']),
    );
  }
}

class CalendarController with ChangeNotifier {
  final Map<DateTime, List<CalendarEvent>> events = {};

  List<CalendarEvent> getEventsForDay(DateTime day) {
    return events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  Future<void> fetchEventsFromBackend(
      DateTime startDate, DateTime endDate) async {
    final url = Uri.parse(
        'https://tosjoin-367404119922.asia-southeast1.run.app/UserEvent');
    try {
      final response = await http.get(
        url.replace(queryParameters: {
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
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
        throw Exception('Failed to load events');
      }
    } catch (e) {
      debugPrint('Error fetching events: $e');
    }
  }
}
