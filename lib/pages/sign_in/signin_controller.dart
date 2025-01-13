import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var accessToken = ''.obs;
  var notificationToken = ''.obs;

  Future<void> login(String accessToken, String notificationToken) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(
            'https://tosjoin-367404119922.asia-southeast1.run.app/AnonymousUser/Login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'AccessToken': accessToken,
          'NotificationToken': notificationToken,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        accessToken = data['AccessToken'];
      } else {
        // Handle error response here
      }
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
