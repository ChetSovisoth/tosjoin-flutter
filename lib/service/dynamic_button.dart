import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/service/color.dart';
import 'package:tosjoin/service/size.dart';

class KButtonWidget extends StatelessWidget {
  const KButtonWidget(
      {super.key, required this.label, this.onPressed, this.color});

  final String label;
  final Color? color;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isAndroid) {
      return ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color ?? kPrimaryColor,
          overlayColor: Colors.white,
          maximumSize: const Size(double.infinity, 55),
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: GetPlatform.isAndroid
                ? BorderRadius.zero
                : BorderRadius.circular(kBorderRadius * 4),
          ),
        ),
        child: Text(
          label.tr,
          style: const TextStyle(
            fontSize: kFontSize * 1.1,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    return SafeArea(
      minimum: EdgeInsets.only(
          bottom: GetPlatform.isAndroid ? 0 : kPadding,
          left: GetPlatform.isAndroid ? 0 : kPadding * 2,
          right: GetPlatform.isAndroid ? 0 : kPadding * 2),
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color ?? kPrimaryColor,
          overlayColor: Colors.white,
          maximumSize: const Size(double.infinity, 55),
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: GetPlatform.isAndroid
                ? BorderRadius.zero
                : BorderRadius.circular(kBorderRadius * 4),
          ),
        ),
        child: Text(
          label.tr,
          style: const TextStyle(
            fontSize: kFontSize * 1.1,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
