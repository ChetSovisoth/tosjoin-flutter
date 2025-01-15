import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tosjoin/service/color.dart';
import 'package:tosjoin/service/size.dart';

class DialogService {
  static Future loading() async {
    return await Get.dialog(
      PopScope(
        canPop: false,
        child: Center(
          child: LoadingAnimationWidget.threeArchedCircle(
            size: kIconSize * 1.4,
            color: Colors.white,
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future confirm(
      {required String title,
      required String content,
      required Function()? onConfirm}) async {
    return await Get.defaultDialog(
      title: title.tr,
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      content: Text(content.tr),
      actions: [
        TextButton(
          style:
              TextButton.styleFrom(overlayColor: kDangerColor.withOpacity(0.1)),
          onPressed: () => Get.back(),
          child: Text('no'.tr, style: const TextStyle(color: kDangerColor)),
        ),
        TextButton(
          style: TextButton.styleFrom(
              overlayColor: kPrimaryColor.withOpacity(0.1)),
          onPressed: onConfirm,
          child: Text('yes'.tr, style: const TextStyle(color: kPrimaryColor)),
        ),
      ],
    );
  }
}
