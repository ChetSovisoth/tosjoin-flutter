import 'package:get/get.dart';
import 'package:tosjoin/pages/theme_mode/theme_mode_controller.dart';

class ThemeModeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeModeController>(() => ThemeModeController());
  }
}
