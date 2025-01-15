// language_binding.dart
import 'package:get/get.dart';
import 'language_controller.dart';

class LanguageBinding implements Bindings {
  @override
  void dependencies() {
    // Lazy initialization of LanguageController
    Get.lazyPut<LanguageController>(() => LanguageController());
  }
}
