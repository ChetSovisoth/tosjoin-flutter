import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'language_controller.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("language".tr),
      ),
      body: Obx(() {
        return Column(
          children: [
            RadioListTile(
              controlAffinity: ListTileControlAffinity.trailing,
              title: Text("English".tr),
              value: 1,
              groupValue: controller.languageSelection.value,
              activeColor: Colors.blue,
              onChanged: controller.onChangeLanguage,
            ),
            RadioListTile(
              controlAffinity: ListTileControlAffinity.trailing,
              title: Text("ខ្មែរ".tr, style: GoogleFonts.kantumruyPro()),
              value: 2,
              groupValue: controller.languageSelection.value,
              activeColor: Colors.blue,
              onChanged: controller.onChangeLanguage,
            ),
          ],
        );
      }),
    );
  }
}
