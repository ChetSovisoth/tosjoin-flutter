import 'package:get/get.dart';
import '../home/xcore.dart';
import '../joined/xcore.dart';
import '../profile/xcore.dart';
import 'calendar_controller.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<JoinController>(() => JoinController());
    Get.lazyPut<CalendarController>(() => CalendarController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
