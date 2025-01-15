import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:tosjoin/pages/calendar/calendar_controller.dart';
import 'package:tosjoin/pages/home/event/event_detail.dart'; // Add this import
import '../../service/cloudflarr2.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  final CloudflareR2Service cloudflareService = CloudflareR2Service();

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
        return 2;
    }
  }

  @override
  void initState() {
    super.initState();
    Get.put(CalendarController());

    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _firstDay = DateTime.now().subtract(const Duration(days: 7));
    _lastDay = DateTime.now().add(const Duration(days: 7));
    final calendarController = Get.find<CalendarController>();
    calendarController.fetchEventsFromBackend(_firstDay, _lastDay);
  }

  @override
  Widget build(BuildContext context) {
    final calendarController = Get.find<CalendarController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Calendar Events"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              if (_selectedDay != selectedDay) {
                calendarController.fetchEventsFromBackend(
                  selectedDay.subtract(const Duration(days: 7)),
                  selectedDay.add(const Duration(days: 7)),
                );
              }
            },
            calendarBuilders: CalendarBuilders(
              // Highlight days with events
              defaultBuilder: (context, date, _) {
                final hasEvents =
                    calendarController.getEventsForDay(date).isNotEmpty;
                if (hasEvents) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.blue
                          .withOpacity(0.1), // Blue background with 10% opacity
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(
                          color: Colors.black, // Default text color
                        ),
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Events',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.filter_list),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount:
                  calendarController.getEventsForDay(_selectedDay).length,
              itemBuilder: (context, index) {
                final event =
                    calendarController.getEventsForDay(_selectedDay)[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: event.attached.isNotEmpty
                        ? FutureBuilder<String>(
                            future: event.getImageUrl(cloudflareService),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Icon(Icons.error),
                                );
                              } else if (snapshot.hasData) {
                                final imageUrl = snapshot.data!;
                                return SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              return const SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(Icons.image_not_supported),
                              );
                            },
                          )
                        : const SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.image_not_supported),
                          ),
                    title: Text(event.title),
                    subtitle: Text(
                      '${event.date.day}/${event.date.month}/${event.date.year}',
                    ),
                    onTap: () {
                      Get.to(
                        () => EventDetailView(
                          eventId: event.id.toString(), // Convert int to String
                          token: 'your-auth-token',
                        ),
                        arguments: {
                          'title': event.title,
                          'date': event.date,
                          'timing': event.timing,
                          'image': event.attached.isNotEmpty
                              ? event.attached[0]
                              : null,
                          'descriptions': event.descriptions,
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}
