import 'package:get/get.dart';

class JoinController extends GetxController {
  var joinedEvents = [
    {
      'date': '9 Jan',
      'title': 'Faculty of Engineering Party',
      'location': 'Building STEM, 704',
      'image': 'lib/assets/event1.jpg', // Direct image URL
    },
    {
      'date': '10 Nov',
      'title': 'The GenAI Conference',
      'location': 'Building STEM, 704',
      'image': 'lib/assets/event1.jpg', // Direct image URL
    },
    {
      'date': '10 Nov',
      'title': 'The GenAI Conference',
      'location': 'Building STEM, 704',
      'image': 'lib/assets/event1.jpg', // Direct image URL
    },
    {
      'date': '10 Nov',
      'title': 'The GenAI Conference',
      'location': 'Building STEM, 704',
      'image': 'lib/assets/event1.jpg', // Direct image URL
    },
    {
      'date': '10 Nov',
      'title': 'The GenAI Conference',
      'location': 'Building STEM, 704',
      'image': 'lib/assets/event1.jpg', // Direct image URL
    },
  ].obs;

  void joinEvent(String eventTitle) {
    print("Joined $eventTitle");
  }
}
