import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class JoinController extends GetxController {
  final joinedEvents = <Map<String, String>>[].obs;
  final _storage = GetStorage(); // Initialize GetStorage

  @override
  void onInit() {
    super.onInit();
    // Load joined events from local storage when the controller is initialized
    final storedEvents = _storage.read<List>('joinedEvents');
    if (storedEvents != null) {
      joinedEvents.addAll(storedEvents.map((e) => Map<String, String>.from(e)));
    }
  }

  void addEvent(Map<String, String> event) {
    if (!isEventJoined(event['title']!)) {
      joinedEvents.add(event);
      _saveJoinedEvents(); // Save joined events to local storage
    }
  }

  void removeEvent(String eventTitle) {
    joinedEvents.removeWhere((event) => event['title'] == eventTitle);
    _saveJoinedEvents(); // Save joined events to local storage
  }

  bool isEventJoined(String eventTitle) {
    return joinedEvents.any((event) => event['title'] == eventTitle);
  }

  // Save joined events to local storage
  void _saveJoinedEvents() {
    _storage.write('joinedEvents', joinedEvents.toList());
  }
}
