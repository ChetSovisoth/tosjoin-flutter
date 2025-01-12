import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signin_controller.dart';

class LoginView extends StatelessWidget {
  final loginController = Get.put(LoginController());

  final TextEditingController accessTokenController = TextEditingController();
  final TextEditingController notificationTokenController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: accessTokenController,
              decoration: InputDecoration(labelText: 'Access Token'),
            ),
            TextField(
              controller: notificationTokenController,
              decoration: InputDecoration(labelText: 'Notification Token'),
            ),
            SizedBox(height: 20),
            Obx(() => loginController.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      loginController.login(
                        accessTokenController.text,
                        notificationTokenController.text,
                      );
                    },
                    child: Text('Login'),
                  )),
          ],
        ),
      ),
    );
  }
}
