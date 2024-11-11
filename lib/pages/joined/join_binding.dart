import 'package:get/get.dart';
import 'package:tosjoin/pages/joined/join_controller.dart';

class JoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JoinController>(() => JoinController());
  }
}
