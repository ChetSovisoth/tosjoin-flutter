import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/pages/home/home_controller.dart';
import 'package:tosjoin/service/cloudflarr2.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());
  final CloudflareR2Service cloudflareService = CloudflareR2Service();

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
              Get.toNamed('/profile');
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.grey),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: "search".tr,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                onChanged: (value) {
                  controller.searchQuery.value = value;
                },
              ),
              const SizedBox(height: 16),
              Obx(() {
                final searchResults =
                    controller.searchEvents(controller.searchQuery.value);
                if (controller.searchQuery.value.isNotEmpty) {
                  return Column(
                    children: [
                      sectionTitle("Search Results"),
                      eventList(searchResults),
                    ],
                  );
                } else {
                  return Column(
                    children: [
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
                                                : Icon(
                                                    category['icon']
                                                        as IconData,
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
                      sectionTitle("upcoming_event".tr),
                      eventList(controller.upcomingEvents),
                      const SizedBox(height: 12),
                      sectionTitle("just-announced".tr),
                      eventList(controller.justAnnouncedEvents),
                    ],
                  );
                }
              }),
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
        currentIndex: _getCurrentIndex(Get.currentRoute),
        onTap: (index) {
          switch (index) {
            case 0:
              if (Get.currentRoute != '/home') {
                Get.offAllNamed('/home');
              }
              break;
            case 1:
              if (Get.currentRoute != '/joined') {
                Get.offAllNamed('/joined');
              }
              break;
            case 2:
              if (Get.currentRoute != '/calendar') {
                Get.offAllNamed('/calendar');
              }
              break;
            case 3:
              if (Get.currentRoute != '/profile') {
                Get.offAllNamed('/profile');
              }
              break;
          }
        },
      ),
    );
  }

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
        return 0;
    }
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

  Widget eventList(List<Map<String, dynamic>> events) {
    if (events.isEmpty) {
      return const Center(
        child: Text("No events found"),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return GestureDetector(
            onTap: () {
              final eventTitle = event['title'] ?? 'Unknown Event';
              controller.joinEvent(eventTitle);
              Get.toNamed(
                '/event-detail',
                arguments: {
                  'eventId': event['id'] ?? 'default-event-id',
                  'event': event, // Pass the entire event map
                },
              );
            },
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
                    FutureBuilder<String>(
                      future: HomeEvent.fromJson(event)
                          .getImageUrl(cloudflareService),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(child: Icon(Icons.error));
                        } else if (snapshot.hasData && snapshot.data != null) {
                          final imageUrl = snapshot.data!;
                          return Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            },
                          );
                        } else {
                          return Image.asset(
                            'lib/assets/event1.jpg', // Fallback image
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          );
                        }
                      },
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Text(
                        event['date'] ?? 'No Date',
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
                              event['title'] ?? 'No Title',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.white, size: 12),
                                const SizedBox(width: 4),
                                Text(
                                  event['location'] ?? 'No Location',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  final eventTitle =
                                      event['title'] ?? 'Unknown Event';
                                  controller.joinEvent(eventTitle);
                                  Get.toNamed(
                                    '/event-detail',
                                    arguments: {
                                      'eventId':
                                          event['id'] ?? 'default-event-id',
                                      'token': 'your-auth-token',
                                    },
                                  );
                                },
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
