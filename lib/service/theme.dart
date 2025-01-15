import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tosjoin/service/color.dart';
import 'package:tosjoin/service/size.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: Colors.white,
  textTheme: Get.locale?.languageCode == "en"
      ? GoogleFonts.robotoTextTheme(
          ThemeData(brightness: Brightness.light).textTheme)
      : GoogleFonts.battambangTextTheme(
          ThemeData(brightness: Brightness.light).textTheme),
  cardColor: kBgPrimary,
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: kBgPrimary,
    indicatorColor: kPrimaryColor.withOpacity(0.8),
    surfaceTintColor: kBgPrimary,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: kPrimaryColor,
    elevation: 0,
    centerTitle: true,
  ),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: Get.locale?.languageCode == "en"
        ? GoogleFonts.roboto(
            color: Colors.grey,
            fontStyle: FontStyle.normal,
            fontSize: kFontSize,
            letterSpacing: 0.15,
          )
        : GoogleFonts.battambang(
            color: Colors.grey,
            fontStyle: FontStyle.normal,
            fontSize: kFontSize,
            letterSpacing: 0.15,
          ),
    hintStyle: GoogleFonts.roboto(
      color: Colors.grey,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.15,
    ),
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    fillColor: Colors.black12.withOpacity(0.03),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(kBorderRadius / 2)),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(kBorderRadius / 2)),
      borderSide: BorderSide(
        color: kInfoColor,
        width: 1.5,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(kBorderRadius / 2)),
      borderSide: BorderSide(
        color: kPrimaryColor,
        width: 1.5,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      side: const WidgetStatePropertyAll(
        BorderSide.none,
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          side: const BorderSide(color: Colors.red),
        ),
      ),
      elevation: const WidgetStatePropertyAll(0.0),
      backgroundColor: const WidgetStatePropertyAll(kPrimaryColor),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          color: Colors.yellow,
        ),
      ),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple, brightness: Brightness.dark),
  useMaterial3: true,
  textTheme: Get.locale?.languageCode == "en"
      ? GoogleFonts.robotoTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme)
      : GoogleFonts.battambangTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.black,
    surfaceTintColor: Colors.black,
  ),
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    centerTitle: true,
  ),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Colors.white,
    unselectedLabelColor: Colors.white,
    indicatorColor: kLightPrimaryColor,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.black26,
    indicatorColor: kPrimaryColor.withOpacity(0.8),
    surfaceTintColor: Colors.black26,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: GoogleFonts.roboto(
      color: Colors.grey,
      fontStyle: FontStyle.normal,
      fontSize: kFontSize,
      letterSpacing: 0.15,
    ),
    hintStyle: GoogleFonts.roboto(
      color: Colors.grey,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.15,
    ),
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    fillColor: Colors.white12.withOpacity(0.03),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(kBorderRadius / 2)),
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 0,
      ),
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(kBorderRadius / 2)),
      borderSide: BorderSide(
        color: kInfoColor,
        width: 1.5,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(kBorderRadius / 2)),
      borderSide: BorderSide(
        color: kPrimaryColor,
        width: 1.5,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      side: const WidgetStatePropertyAll(BorderSide.none),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          side: const BorderSide(color: Colors.red),
        ),
      ),
      elevation: const WidgetStatePropertyAll(0.0),
      backgroundColor: const WidgetStatePropertyAll(kPrimaryColor),
      textStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.yellow)),
    ),
  ),
);
