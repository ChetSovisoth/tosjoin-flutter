import 'package:get/get.dart';

class ProfileController extends GetxController {
  // User data from WelcomeController (can be passed or fetched from storage)
  var userData = {}.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void updateUserProfile(String picture, String email, String name) {
    userData.value = {
      'picture': picture,
      'email': email,
      'name': name,
      'sub': userData['sub'],
      'identifier': userData['identifier'],
    };
    // Optionally save it locally or in your backend
  }
}
