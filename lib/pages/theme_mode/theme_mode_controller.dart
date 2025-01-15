import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/service/storage_service.dart';

class ThemeModeController extends GetxController {
  ThemeModeController();

  final themeMode = RxInt(0); // 0: System, 1: Light, 2: Dark
  final storage = Get.find<StorageService>();

  @override
  void onInit() {
    super.onInit();
    getThemeMode();
  }

  // Change the theme mode and save it to storage
  void onChangeThemeMode(int? i) {
    if (i == null) return;

    themeMode.value = i;

    switch (i) {
      case 1:
        Get.changeThemeMode(ThemeMode.light);
        storage.setTheme(mode: ThemeMode.light);
        break;
      case 2:
        Get.changeThemeMode(ThemeMode.dark);
        storage.setTheme(mode: ThemeMode.dark);
        break;
      default:
        Get.changeThemeMode(ThemeMode.system);
        storage.setTheme(mode: ThemeMode.system);
        break;
    }
  }

  // Retrieve the saved theme mode from storage
  void getThemeMode() {
    final savedTheme = storage.getTheme();
    switch (savedTheme) {
      case ThemeMode.light:
        themeMode.value = 1;
        break;
      case ThemeMode.dark:
        themeMode.value = 2;
        break;
      default:
        themeMode.value = 0;
        break;
    }
  }
}
