import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/pages/home/home_binding.dart';
import 'package:tosjoin/pages/home/home_view.dart';
import 'package:tosjoin/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(), // Setting up initial binding if needed
      home: const SplashScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: '/home', page: () => HomeView(), binding: HomeBinding()),
        // Add other routes here
      ],
    );
  }
}
