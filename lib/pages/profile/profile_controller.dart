import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tosjoin/pages/home/home_controller.dart';
import 'package:tosjoin/pages/profile/profile_model.dart';
import 'package:tosjoin/pages/profile/profile_route.dart';
import 'package:tosjoin/service/dialog_loading.dart';
import 'package:tosjoin/service/enum.dart';
import 'package:tosjoin/service/storage_service.dart';

class ProfileController extends GetxController {
  ProfileController();

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
  final imageObj = Rxn<Object>(null);

  Future<void> getProfile() async {
    isLoading(true);
    try {
      final response = await GetConnect().get('/MobileUser/MyProfile');
      if (response.statusCode == 200 && response.body != null) {
        profile.value = ProfileModel.fromJson(response.body);
        nameController.text = profile.value.username;
      } else {
        Get.snackbar('Error', 'Failed to fetch profile data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> onUpdateProfile() async {
    if (imageObj.value is XFile) {
      DialogService.loading();

      try {
        final imageFile = imageObj.value as XFile;
        final formData = FormData({
          'file': MultipartFile(
            await imageFile.readAsBytes(),
            filename: imageFile.name,
          ),
        });

        final response = await GetConnect().post(
          '/MobileUser/UpdateProfile',
          formData,
        );

        Get.back(); // Dismiss loading dialog

        if (response.statusCode == 200) {
          await Get.find<HomeController>().getProfile();
          await getProfile();
        } else {
          Get.snackbar('Error', 'Failed to update profile');
        }
      } catch (e) {
        Get.back(); // Ensure dialog is dismissed in case of error
        Get.snackbar('Error', 'An error occurred: $e');
      }
    }
  }

  Future<void> onSignOut() async {
    DialogService.confirm(
      title: 'sign_out',
      content: 'sign-out-d',
      onConfirm: () {
        DialogService.loading();
        Get.find<StorageService>().setLogout();
        Get.back(); // Close the loading dialog
        Get.back(); // Close the confirmation dialog
        Get.offAllNamed(ProfileRoute.splashScreen);
      },
    );
  }
}
