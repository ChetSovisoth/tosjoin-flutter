import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/pages/profile/edit_profile/edit_profile_controller.dart';
import 'package:tosjoin/service/color.dart';
import 'package:tosjoin/service/dynamic_button.dart';
import 'package:tosjoin/service/list_tile_widget.dart';
import 'package:tosjoin/service/loading_widget.dart';
import 'package:tosjoin/service/size.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edit_profile".tr),
        actions: [
          TextButton(
            onPressed: () {
              // Handle delete account action
            },
            child: Text(
              "deleted-account".tr,
              style: const TextStyle(
                color: kDangerColor,
                fontSize: kFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: kSpace / 2), // Replaced Gap with SizedBox
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const LoadingWidget();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding * 2),
          child: Form(
            key: controller.fromKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: ListTile.divideTiles(
                      context: context,
                      color: Colors.blueGrey.withOpacity(0.2),
                      tiles: [
                        ListTileField(
                          label: "name",
                          controller: controller.nameController,
                          isReadOnly: false,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "name_required".tr;
                            }
                            return null;
                          },
                        ),
                        Visibility(
                          visible: controller.profile.value.position != null,
                          child: ListTileField(
                            label: "position",
                            value: "${controller.profile.value.position}",
                          ),
                        ),
                      ],
                    ).toList(),
                  ),
                ),
                Visibility(
                  visible: GetPlatform.isIOS,
                  child: KButtonWidget(
                    label: "update",
                    onPressed: () {
                      // Handle update action
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      bottomSheet: Obx(() {
        if (controller.isLoading.isTrue) {
          return const SizedBox();
        }
        return Visibility(
          visible: GetPlatform.isAndroid,
          child: KButtonWidget(
            label: "update",
            onPressed: () {
              // Handle update action
            },
          ),
        );
      }),
    );
  }
}
