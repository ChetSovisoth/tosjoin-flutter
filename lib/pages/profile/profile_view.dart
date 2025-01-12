import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profile_controller.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
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
                    profileController.userData['picture'] ??
                        'https://via.placeholder.com/150',
                  ),
                  onBackgroundImageError: (exception, stackTrace) {
                    // Handle the error, e.g., log it or use a fallback image
                    print("Failed to load image: $exception");
                  },
                  child: profileController.userData['picture'] == null
                      ? Icon(Icons.person, size: 50) // Fallback icon
                      : null,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: TextEditingController(
                      text: profileController.userData['name']),
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (value) {
                    profileController.updateUserProfile(
                      profileController.userData['picture'] ?? '',
                      profileController.userData['email'] ?? '',
                      value,
                    );
                  },
                ),
                SizedBox(height: 16),
                TextField(
                  controller: TextEditingController(
                      text: profileController.userData['email']),
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (value) {
                    profileController.updateUserProfile(
                      profileController.userData['picture'] ?? '',
                      value,
                      profileController.userData['name'] ?? '',
                    );
                  },
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    // Save changes or call API to update the user profile
                    print("Profile updated: ${profileController.userData}");
                  },
                  child: Text("Save Changes"),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
