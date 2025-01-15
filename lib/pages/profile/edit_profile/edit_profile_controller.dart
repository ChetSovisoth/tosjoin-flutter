import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/pages/profile/profile_model.dart';
import 'package:tosjoin/service/enum.dart';

class EditProfileController extends GetxController {
  EditProfileController();

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  final profile = Rx<ProfileModel>(
      ProfileModel(username: 'NAN', role: UserRole.user, profile: ''));
  final isLoading = RxBool(true);
  final nameController = TextEditingController(text: "NAN");
  final fromKey = GlobalKey<FormState>();

  Future<void> getProfile() async {
    isLoading(true);
    try {
      const String apiUrl =
          'https://tosjoin-367404119922.asia-southeast1.run.app/MobileUser/MyProfile';
      final response = await GetConnect().get(apiUrl);
      if (response.statusCode == 200 && response.body != null) {
        profile.value = ProfileModel.fromJson(response.body);
        nameController.text = profile.value.username;
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch profile data. Status Code: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      // Stop loading
      isLoading(false);
    }
  }
}
