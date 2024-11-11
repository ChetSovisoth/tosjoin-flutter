// import 'package:des_app/core/service/auth_zero.dart';
// import 'package:get/get.dart';
// import 'package:des_app/xcore.dart';

// class SignInController extends GetxController {

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   final storage = Get.find<StorageService>();
//   Future<void> onJoinWithGoogle() async {
//     final response = await AuthService().onJoinWithGoogle();
//     storage.setToken(response.accessToken);
//     storage.setProfile(response.user);
//     Get.offNamed(PagesRoute.page);
//   }

//   Future<void> onJoinWithApple() async {
//     final response = await AuthService().onJoinWithApple();
//     storage.setToken(response.accessToken);
//     storage.setProfile(response.user);
//     Get.offNamed(PagesRoute.page);
//   }
// }
