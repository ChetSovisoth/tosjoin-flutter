import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/pages/joined/join_controller.dart';

class JoinView extends StatefulWidget {
  const JoinView({super.key});

  @override
  State<JoinView> createState() => _JoinViewState();
}

class _JoinViewState extends State<JoinView> {
  final JoinController _controller = Get.put(JoinController());
  int _getCurrentIndex(String route) {
    switch (route) {
      case '/home':
        return 0;
      case '/joined':
        return 1;
      case '/calendar':
        return 2;
      case '/profile':
        return 3;
      default:
        return 1; // Default to 'Joined' tab
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joined Events'),
        centerTitle: true,
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: Obx(
        () {
          if (_controller.joinedEvents.isEmpty) {
            return const Center(child: Text("No events joined yet."));
          } else {
            return eventList(_controller.joinedEvents);
          }
        },
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            _getCurrentIndex(Get.currentRoute), // Highlight current tab
        onTap: (index) {
          switch (index) {
            case 0:
              if (Get.currentRoute != '/home') {
                Get.offAllNamed('/home'); // Navigate to HomeView
              }
              break;
            case 1:
              if (Get.currentRoute != '/joined') {
                Get.offAllNamed('/joined'); // Navigate to JoinView
              }
              break;
            case 2:
              if (Get.currentRoute != '/calendar') {
                Get.offAllNamed('/calendar'); // Navigate to CalendarView
              }
              break;
            case 3:
              if (Get.currentRoute != '/profile') {
                Get.offAllNamed('/profile'); // Navigate to ProfileView
              }
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.join_full_outlined), label: 'Joined'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.purple, // Color for selected icon
        unselectedItemColor: Colors.grey, // Color for unselected icons
      ),
    );
  }

  Widget eventList(RxList<Map<String, String>> events) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        crossAxisSpacing: 8, // Space between columns
        mainAxisSpacing: 13, // Space between rows
        childAspectRatio: 0.75, // Aspect ratio for each box (adjust as needed)
      ),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return GestureDetector(
          onTap: () => _controller.removeEvent(event['title']!),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white, // Optional: background color
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(event['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Text(
                      event['date']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.black54,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event['title']!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  color: Colors.white, size: 12),
                              const SizedBox(width: 4),
                              Text(
                                event['location']!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 11),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () =>
                                  _controller.removeEvent(event['title']!),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 8, 24, 238),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Joined",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
