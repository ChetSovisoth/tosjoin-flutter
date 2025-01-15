import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tosjoin/pages/calendar/calendar_binding.dart';
import 'package:tosjoin/pages/calendar/calendar_view.dart';
import 'package:tosjoin/pages/home/event/event_detail.dart';
import 'package:tosjoin/pages/home/home_binding.dart';
import 'package:tosjoin/pages/home/home_view.dart';
import 'package:tosjoin/pages/joined/join_binding.dart';
import 'package:tosjoin/pages/joined/join_view.dart';
import 'package:tosjoin/pages/language/language_binding.dart';
import 'package:tosjoin/pages/language/language_view.dart';
import 'package:tosjoin/pages/profile/profile_binding.dart';
import 'package:tosjoin/pages/profile/profile_route.dart';
import 'package:tosjoin/pages/profile/profile_view.dart';
import 'package:tosjoin/pages/theme_mode/theme_mode_binding.dart';
import 'package:tosjoin/pages/theme_mode/theme_mode_view.dart';
import 'package:tosjoin/screen/splash_screen.dart';
import 'package:tosjoin/service/local_string.dart';
import 'package:tosjoin/service/storage_service.dart';

Future<void> main() async {
  await GetStorage.init(); // Initialize GetStorage
  Get.put(StorageService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storageService = Get.find<StorageService>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      initialBinding: HomeBinding(), // Initial binding for the app
      home: const SplashScreen(), // SplashScreen as the initial screen
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomeView(), // Route for HomeView
          binding: HomeBinding(), // Bindings for HomeView
        ),
        GetPage(
          name: '/joined',
          page: () => JoinView(), // Route for JoinView
          binding: JoinBinding(), // Bindings for JoinView
        ),
        GetPage(
          name: '/calendar',
          page: () => CalendarView(), // Route for CalendarView
          binding: CalendarBinding(), // Bindings for CalendarView
        ),
        GetPage(
          name: '/profile',
          page: () => ProfileView(), // Route for ProfileView
          binding: ProfileBinding(), // Bindings for ProfileView
        ),
        GetPage(
          name: '/language',
          page: () => const LanguageView(), // Route for LanguageView
          binding: LanguageBinding(), // Bindings for LanguageView
        ),
        GetPage(
          name: '/theme-mode',
          page: () => const ThemeModeView(), // Route for ThemeModeView
          binding: ThemeModeBinding(), // Bindings for ThemeModeView
        ),
        GetPage(
          name: '/event-detail',
          page: () {
            final arguments = Get.arguments;
            return EventDetailView(
              eventId: arguments['eventId'], // Pass eventId from arguments
              token: arguments['token'], // Pass token from arguments
            );
          },
        ),
        ...ProfileRoute.routes,
      ],
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(), // Default light theme
      translations: LocalString(), // Add your translations class here
      locale: const Locale('en', 'US'), // Default locale
      fallbackLocale: const Locale('en', 'US'), // Fallback locale
    );
  }
}
