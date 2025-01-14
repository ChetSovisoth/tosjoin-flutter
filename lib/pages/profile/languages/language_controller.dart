// language_controller.dart
import 'package:get/get.dart';
import 'package:tosjoin/strings/text_strings.dart';

class LanguageController extends GetxController {
  var currentLanguage = 'English (UK)'.obs;

  void switchLanguage(String language) {
    currentLanguage.value = language;
    Get.reloadAll(); // Reloads all widgets to reflect language changes
  }

  Map<String, String> getTexts() {
    if (currentLanguage.value == 'Khmer (Cambodia)') {
      return TextString.khmerTexts;
    }
    return TextString.englishTexts;
  }
}