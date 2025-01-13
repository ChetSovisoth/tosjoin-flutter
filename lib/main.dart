import 'package:flutter/material.dart';
<<<<<<< HEAD
// import 'package:project_flutter/pages/auth/login.dart';
import 'package:project_flutter/pages/auth/register.dart';
=======
import 'package:get/get.dart';
import 'package:tosjoin/pages/home/home_binding.dart';
import 'package:tosjoin/pages/home/home_view.dart';
import 'package:tosjoin/screen/splash_screen.dart';
>>>>>>> db7a540069c78323e7b3c5835fe4da9e5d92b4c5

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(debugShowCheckedModeBanner: false, home: Scaffold(body: Register(),));
=======
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
>>>>>>> db7a540069c78323e7b3c5835fe4da9e5d92b4c5
  }
}
