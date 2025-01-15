import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tosjoin/pages/language/language_binding.dart';
import 'package:tosjoin/pages/language/language_view.dart';
import 'package:tosjoin/pages/profile/profile_controller.dart';
import 'package:tosjoin/pages/profile/profile_route.dart';
import 'package:tosjoin/pages/theme_mode/theme_mode_binding.dart';
import 'package:tosjoin/pages/theme_mode/theme_mode_view.dart';
import 'package:tosjoin/service/color.dart';
import 'package:tosjoin/service/edit_profile.dart';
import 'package:tosjoin/service/list_tile_widget.dart';
import 'package:tosjoin/service/size.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  // Helper method to get the current index based on the route
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
        return 3; // Default to 'Profile' tab
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.black87 : Colors.white,
        title: Text(
          "profile".tr,
          style: const TextStyle(
            fontSize: 16 * 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sync),
            tooltip: "sync".tr,
          ),
          const SizedBox(width: 10 / 2), // Replaced Gap with SizedBox
        ],
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10), // Replaced Gap with SizedBox
          Obx(() {
            return ProfileUserWidget(
              image: controller.imageObj.value,
              onCamera: () async {
                final XFile? image =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (image != null) {
                  controller.imageObj(image);
                  Get.back();
                  controller.onUpdateProfile();
                }
              },
              onGallery: () async {
                final XFile? image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  controller.imageObj(image);
                  Get.back();
                  controller.onUpdateProfile();
                }
              },
            );
          }),
          const SizedBox(height: kSpace * 2), // Replaced Gap with SizedBox
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding * 3),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: ListTile.divideTiles(
                  context: context,
                  color: Colors.blueGrey.withOpacity(0.2),
                  tiles: [
                    ListTileWidget(
                      title: "edit_profile",
                      icon: Icons.person,
                      onTap: () {
                        Get.toNamed(ProfileRoute.editProfile);
                      },
                    ),
                    ListTileWidget(
                      title: "language",
                      icon: Icons.language,
                      onTap: () {
                        Get.to(
                          () => const LanguageView(),
                          binding: LanguageBinding(),
                          fullscreenDialog: true,
                          opaque: false,
                          popGesture: true,
                        );
                      },
                    ),
                    ListTileWidget(
                      title: "theme",
                      icon: Icons.contrast,
                      onTap: () {
                        Get.to(
                          () => const ThemeModeView(),
                          binding: ThemeModeBinding(),
                          fullscreenDialog: true,
                          opaque: false,
                          popGesture: true,
                        );
                      },
                    ),
                    ListTileWidget(
                      title: "term",
                      icon: Icons.gavel,
                      onTap: () {},
                    ),
                    ListTileWidget(
                      title: "privacy_policy",
                      icon: Icons.privacy_tip_outlined,
                      onTap: () {},
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Get.isDarkMode
                            ? Colors.redAccent.withOpacity(0.3)
                            : kDangerColor.withOpacity(0.05),
                        child: Transform.flip(
                          flipX: true,
                          child: Icon(Icons.logout_rounded,
                              color:
                                  Get.isDarkMode ? Colors.white : kDangerColor),
                        ),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: kSpace / 2),
                      splashColor: kDangerColor.withOpacity(0.01),
                      visualDensity: VisualDensity.standard,
                      title: Text(
                        "sign_out".tr,
                        style: TextStyle(
                          color:
                              Get.isDarkMode ? Colors.redAccent : kDangerColor,
                          fontSize: kFontSize,
                        ),
                      ),
                      onTap: controller.onSignOut,
                    ),
                  ],
                ).toList(),
              ),
            ),
          ),
        ],
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
}
