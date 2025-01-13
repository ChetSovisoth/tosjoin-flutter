import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:tosjoin/pages/calendar/calendar_controller.dart';
import 'package:tosjoin/pages/joined/join_view.dart';
import 'package:tosjoin/pages/home/home_view.dart';
import '../profile/profile_view.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  int _selectedIndex = 2;
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 7));
    _lastDay = DateTime.now().add(const Duration(days: 7));

    // Fetch events for the initial two-week period
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
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const JoinView()),
        );
        break;
      case 2:
        break; // Stay on CalendarView
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileView()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final calendarController = Get.find<CalendarController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar Events"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              eventLoader: (day) => calendarController.getEventsForDay(day),
              onPageChanged: (focusedDay) {
                // Update focused day and fetch events for the new period
                setState(() {
                  _focusedDay = focusedDay;
                  _firstDay = focusedDay.subtract(const Duration(days: 7));
                  _lastDay = focusedDay.add(const Duration(days: 7));
                });
                calendarController.fetchEventsFromBackend(_firstDay, _lastDay);
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
