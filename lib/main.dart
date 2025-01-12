import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tosjoin/pages/home/home_binding.dart';
import 'package:tosjoin/pages/home/home_view.dart';
import 'package:tosjoin/screen/splash_screen.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding:
          HomeBinding(), // Initial binding setup for your home screen
      home: const SplashScreen(), // SplashScreen as the initial screen
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set your theme
      ),
      getPages: [
        // Set up the routes for your app
        GetPage(
          name: '/home',
          page: () => HomeView(), // Route for HomeView
          binding: HomeBinding(), // Bindings for HomeView
        ),
        // You can add more routes here
      ],
    );
  }
}
