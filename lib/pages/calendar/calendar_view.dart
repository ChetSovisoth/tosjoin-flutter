import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:tosjoin/pages/calendar/calendar_controller.dart';
import 'package:tosjoin/pages/joined/join_view.dart';
import 'package:tosjoin/pages/home/home_view.dart';
import 'package:tosjoin/pages/profile/profile_view.dart';
import '../../service/cloudflarr2.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  int _selectedIndex = 2;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  final CloudflareR2Service cloudflareService =
      CloudflareR2Service(); // Instantiate the service

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeView()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const JoinView()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileView()),
        ); // Stay on CalendarView
    }
  }

  @override
  Widget build(BuildContext context) {
    final calendarController = Get.find<CalendarController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Calendar Events"),
        automaticallyImplyLeading: false, // Remove the back button
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
                final calendarController = Get.find<CalendarController>();
                calendarController.fetchEventsFromBackend(
                  selectedDay.subtract(const Duration(days: 7)),
                  selectedDay.add(const Duration(days: 7)),
                );
              }
            },
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
                                    child: Icon(Icons
                                        .error), // Show error icon or placeholder
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
                                        if (loadingProgress == null) {
                                          return child; // Show image once loaded
                                        }
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
                                  child: Icon(Icons
                                      .image_not_supported), // Default icon if no image is attached
                                );
                              },
                            )
                          : const SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(Icons
                                  .image_not_supported), // Default icon if no image is attached
                            ),
                      title: Text(event.title),
                      subtitle: Text(
                        '${event.date.day}/${event.date.month}/${event.date.year}',
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
