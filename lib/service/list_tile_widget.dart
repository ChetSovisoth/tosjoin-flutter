import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/service/color.dart';
import 'package:tosjoin/service/size.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget(
      {super.key,
      required this.title,
      this.subtitle,
      required this.icon,
      this.onTap});
  final String title;
  final String? subtitle;
  final IconData icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Get.isDarkMode ? Colors.white12 : kTextFieldColor,
        child:
            Icon(icon, color: Get.isDarkMode ? Colors.white : Colors.black87),
      ),
      trailing: Icon(GetPlatform.isAndroid
          ? Icons.arrow_forward_rounded
          : Icons.arrow_forward_ios_rounded),
      contentPadding: const EdgeInsets.symmetric(horizontal: kSpace / 2),
      visualDensity: VisualDensity.standard,
      title: Text(
        title.tr,
        style: const TextStyle(
          fontSize: kFontSize,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!.tr,
              style: const TextStyle(
                fontSize: kFontSize,
              ),
            )
          : null,
      splashColor: kPrimaryColor.withValues(alpha: 0.01),
      onTap: onTap,
    );
  }
}

class ListTileField extends StatelessWidget {
  const ListTileField(
      {super.key,
      required this.label,
      this.value,
      this.locale = const Locale('en', 'US'),
      this.isReadOnly = true,
      this.controller,
      this.hintText,
      this.keyboardType,
      this.validator,
      this.isRequired = false,
      this.maxLines,
      this.doAnimate});
  final String label;
  final String? value;
  final Locale? locale;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? isReadOnly;
  final bool? isRequired;
  final int? maxLines;
  final bool? doAnimate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      title: ShakeX(
        animate: doAnimate ?? false,
        duration: const Duration(milliseconds: 800),
        from: 6,
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: label.tr,
                style: TextStyle(
                  color: kInfoColor,
                  fontSize: Get.locale?.languageCode == 'en'
                      ? kFontSize * 0.9
                      : kFontSize * 1.1,
                ),
              ),
              TextSpan(
                text: isRequired == false ? '' : ' *',
                style: TextStyle(
                  color: kDangerColor,
                  fontSize: Get.locale?.languageCode == 'en'
                      ? kFontSize * 0.9
                      : kFontSize * 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
      subtitle: _field(),
    );
  }

  Widget _field() {
    if (isReadOnly == true) {
      return Text(
        value ?? 'NAN',
        style: TextStyle(
          fontSize: kFontSize * 1.1,
          fontWeight: FontWeight.w600,
          locale: locale,
        ),
      );
    }
    return TextFormField(
      controller: controller,
      cursorColor: kPrimaryColor,
      validator: validator,
      decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
        hintText: hintText?.tr,
        hintStyle: TextStyle(
          color: Get.isDarkMode ? Colors.white : Colors.grey.shade500,
          fontSize: kFontSize * 1,
          fontWeight: FontWeight.w300,
          locale: locale,
        ),
        contentPadding: EdgeInsets.zero,
        fillColor: Colors.transparent,
        focusedBorder: InputBorder.none,
        suffix: const Icon(Icons.edit, size: kFontSize * 1.1),
      ),
      onTapOutside: (e) => FocusScope.of(Get.context!).unfocus(),
      maxLines: maxLines,
      style: TextStyle(
        color: Get.isDarkMode ? Colors.white : Colors.grey.shade800,
        fontSize: kFontSize * 1.1,
        fontWeight: FontWeight.w600,
        locale: locale,
      ),
    );
  }
}

class ListTileFormField extends StatelessWidget {
  const ListTileFormField(
      {super.key,
      required this.label,
      this.locale = const Locale('en', 'US'),
      this.controller,
      this.keyboardType,
      this.validator,
      this.hintText,
      this.isReadOnly = false});
  final String label;
  final Locale? locale;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? isReadOnly;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: kSpace / 2, vertical: 0),
      title: Text(
        label.tr,
        style: TextStyle(
          color: kInfoColor,
          fontSize: Get.locale?.languageCode == 'en'
              ? kFontSize * 0.9
              : kFontSize * 1.1,
        ),
      ),
      subtitle: TextFormField(
        controller: controller,
        cursorColor: kPrimaryColor,
        validator: validator,
        readOnly: isReadOnly ?? false,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          fillColor: Colors.transparent,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.grey.shade500,
            fontSize: kFontSize * 1,
            fontWeight: FontWeight.w300,
            locale: locale,
          ),
          hintFadeDuration: const Duration(milliseconds: 500),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              width: 1.3,
              color: Get.isDarkMode ? Colors.white24 : Colors.grey.shade300,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              width: 1.3,
              color: Get.isDarkMode ? Colors.white24 : Colors.grey.shade300,
            ),
          ),
        ),
        onTapOutside: (e) => FocusScope.of(Get.context!).unfocus(),
        maxLines: 1,
        style: TextStyle(
          color: Get.isDarkMode ? Colors.white : Colors.grey.shade800,
          fontSize: kFontSize * 1.1,
          fontWeight: FontWeight.w600,
          locale: locale,
        ),
      ),
    );
  }
}
