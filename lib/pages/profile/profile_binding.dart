import 'package:get/get.dart';
import 'package:tosjoin/pages/profile/profile_controller.dart';

class JoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
