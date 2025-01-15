import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/service/storage_service.dart';

class LanguageController extends GetxController {
  final storage = Get.find<StorageService>();

  final languageSelection = RxInt(0); // Observable for selected language

  @override
  void onInit() {
    getLanguage(); // Fetch saved language on initialization
    super.onInit();
  }

  // Method to change the app's language
  Future<void> onChangeLanguage(int? i) async {
    if (i == null) return;

    Locale locale;
    if (i == 1) {
      locale = const Locale('en', 'US');
    } else {
      locale = const Locale('kh', 'CM');
    }

    // Save the selected locale and update the app's language
    await storage.setLocale(language: locale);
    Get.updateLocale(locale);
    languageSelection.value = i;
  }

  void getLanguage() {
    final savedLocale = storage.getLocal();
    languageSelection.value = savedLocale.languageCode == 'en' ? 1 : 2;
  }
}
