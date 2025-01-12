import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../pages/home/xcore.dart';

class WelcomeController extends GetxController {
  var isLoading = false.obs;

  Future<void> loginDemoUser(String picture, String email, String name,
      String sub, String identifier) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(
            'https://tosjoin-367404119922.asia-southeast1.run.app/AnonymousUser/LoginDemoUser'),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'picture': picture,
          'email': email,
          'name': name,
          'sub': sub,
          'identifier': identifier,
        }),
      );

      if (response.statusCode == 200) {
        String token = response.body;
        if (token.isNotEmpty) {
          final box = GetStorage();
          box.write('accessToken', token);
          Get.to(() => HomeView());
        } else {
          print("Error: Token not found in response.");
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
