import 'package:get/get.dart';

class JoinController extends GetxController {
  var joinedEvents = <Map<String, String>>[].obs;

  // Method to add an event to the joined events list
  void addEvent(Map<String, String> event) {
    if (!isEventJoined(event['title']!)) {
      joinedEvents.add(event);
    }
  }

  // Method to remove an event from the joined events list
  void removeEvent(String eventTitle) {
    joinedEvents.removeWhere((event) => event['title'] == eventTitle);
  }

  // Method to check if an event is already joined
  bool isEventJoined(String eventTitle) {
    return joinedEvents.any((event) => event['title'] == eventTitle);
  }
}
