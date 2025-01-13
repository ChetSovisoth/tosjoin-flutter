import 'package:get/get.dart';
import 'package:tosjoin/pages/home/event/event_controller.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventDetailController>(() => EventDetailController());
  }
}
