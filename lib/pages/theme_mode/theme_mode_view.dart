import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/pages/theme_mode/theme_mode_controller.dart';
import 'package:tosjoin/service/color.dart';

class ThemeModeView extends GetView<ThemeModeController> {
  const ThemeModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("theme".tr),
      ),
      body: Obx(() {
        return Column(
          children: [
            RadioListTile(
              controlAffinity: ListTileControlAffinity.trailing,
              title: Text("light".tr),
              value: 1,
              groupValue: controller.themeMode.value,
              activeColor: kPrimaryColor,
              onChanged: controller.onChangeThemeMode,
            ),
            RadioListTile(
              title: Text("dark".tr),
              controlAffinity: ListTileControlAffinity.trailing,
              value: 2,
              groupValue: controller.themeMode.value,
              activeColor: kPrimaryColor,
              onChanged: controller.onChangeThemeMode,
            ),
            RadioListTile(
              title: Text("system".tr),
              controlAffinity: ListTileControlAffinity.trailing,
              value: 0,
              groupValue: controller.themeMode.value,
              activeColor: kPrimaryColor,
              onChanged: controller.onChangeThemeMode,
            ),
          ],
        );
      }),
    );
  }
}
