import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/pages/calendar/calendar_view.dart';
import 'package:tosjoin/pages/joined/join_view.dart';
import 'package:tosjoin/pages/home/home_view.dart'; // Import HomeView if it exists

import 'profile_controller.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileController _controller = Get.put(ProfileController());
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Get.to(() => HomeView());
    }
    if (index == 1) {
      Get.to(() => JoinView());
    }
    if (index == 2) {
      Get.to(() => CalendarView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    _controller.userData['picture'] ??
                        'https://via.placeholder.com/150',
                  ),
                  onBackgroundImageError: (exception, stackTrace) {
                    // Handle the error, e.g., log it or use a fallback image
                    print("Failed to load image: $exception");
                  },
                  child: _controller.userData['picture'] == null
                      ? Icon(Icons.person, size: 50) // Fallback icon
                      : null,
                ),
                SizedBox(height: 16),
                TextField(
                  controller:
                      TextEditingController(text: _controller.userData['name']),
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (value) {
                    _controller.updateUserProfile(
                      _controller.userData['picture'] ?? '',
                      _controller.userData['email'] ?? '',
                      value,
                    );
                  },
                ),
                SizedBox(height: 16),
                TextField(
                  controller: TextEditingController(
                      text: _controller.userData['email']),
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (value) {
                    _controller.updateUserProfile(
                      _controller.userData['picture'] ?? '',
                      value,
                      _controller.userData['name'] ?? '',
                    );
                  },
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    // Save changes or call API to update the user profile
                    print("Profile updated: ${_controller.userData}");
                  },
                  child: Text("Save Changes"),
                ),
              ],
            );
          }),
        ),
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
        selectedItemColor: Colors.purple, // Color for selected icon
        unselectedItemColor: Colors.grey, // Color for unselected icons
      ),
    );
  }
}
