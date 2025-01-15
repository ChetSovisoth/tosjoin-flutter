import 'package:get/get.dart';
import 'package:tosjoin/pages/profile/edit_profile/edit_profile_binding.dart';
import 'package:tosjoin/pages/profile/edit_profile/edit_profile_view.dart';
import 'package:tosjoin/screen/splash_screen.dart';

class ProfileRoute {
  static const String editProfile = '/edit_profile';
  static const String deleteAccount = '/delete_account';
  static const String splashScreen = '/splash_screen';

  static final routes = <GetPage>[
    GetPage(
      name: editProfile,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
  ];
}
