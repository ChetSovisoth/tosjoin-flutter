import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/pages/joined/join_view.dart';
import '../calendar/xcore.dart'; // Ensure this is the correct import path
import '../profile/profile_view.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("SA EVENT", style: TextStyle(color: Colors.purple)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.grey),
            onPressed: () {
              // You can add functionality here
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.grey),
          onPressed: () {
            // You can add functionality here
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.categories
                          .map((category) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    category['icon'] is String
                                        ? Image.asset(
                                            category['icon'] as String,
                                            width: 80,
                                            height: 80)
                                        : Icon(category['icon'] as IconData,
                                            size: 40),
                                    const SizedBox(height: 4),
                                    Text(category['name'] as String),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  )),
              const SizedBox(height: 12),
              sectionTitle("Upcoming Events"),
              Obx(() => eventList(controller.upcomingEvents)),
              const SizedBox(height: 12),
              sectionTitle("Just Announced"),
              Obx(() => eventList(controller.justAnnouncedEvents)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.join_full_outlined), label: 'Joined'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              // Do nothing, we're already in HomeView
              break;
            case 1:
              // Navigate to Joined page
              Get.to(() => const JoinView());
              break;
            case 2:
              // Navigate to Calendar page
              Get.to(() => const CalendarView());
              break;
            case 3:
              // Navigate to Profile page
              Get.to(() => ProfileView());
              break;
          }
        },
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextButton(
            onPressed: () {},
            child:
                const Text("see all", style: TextStyle(color: Colors.purple))),
      ],
    );
  }

  Widget eventList(RxList<Map<String, String>> events) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return GestureDetector(
            onTap: () => controller.joinEvent(event['title']!),
            child: Container(
              width: 175,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
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
                                    controller.joinEvent(event['title']!),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 8, 24, 238),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  "Join",
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
      ),
    );
  }
}
