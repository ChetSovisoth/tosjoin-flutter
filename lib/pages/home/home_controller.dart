import 'package:get/get.dart';

class HomeController extends GetxController {
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
  // Sample events
  var upcomingEvents = [
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
  ].obs;

  var justAnnouncedEvents = [
    {
      'date': '23 Dec',
      'title': 'Engineering Day, RUPP',
      'location': 'Building CKCC, NCC',
      'image': 'lib/assets/event1.jpg'
    },
    {
      'date': '2 Sep',
      'title': 'Microsoft and OpenAI at...',
      'location': 'Building STEM, 704',
      'image': 'lib/assets/event1.jpg'
    },
    {
      'date': '2 Sep',
      'title': 'Microsoft and OpenAI at...',
      'location': 'Building STEM, 704',
      'image': 'lib/assets/event1.jpg'
    },
    {
      'date': '2 Sep',
      'title': 'Microsoft and OpenAI at...',
      'location': 'Building STEM, 704',
      'image': 'lib/assets/event1.jpg'
    },
  ].obs;

  void joinEvent(String eventTitle) {
    print("Joined $eventTitle");
  }
}
