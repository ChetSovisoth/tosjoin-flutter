import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/pages/joined/join_controller.dart';
import '../../../base/app_style.dart';

class JoinButton extends StatelessWidget {
  final Map<String, String> event;
  final VoidCallback onJoinPressed;

  const JoinButton({
    super.key,
    required this.event,
    required this.onJoinPressed,
  });

  @override
  Widget build(BuildContext context) {
    final JoinController joinController = Get.find<JoinController>();
    final isJoined = joinController.isEventJoined(event['title']!);

    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onJoinPressed,
        style: isJoined ? AppStyles.grayButtonStyle : AppStyles.blueButtonStyle,
        child: Text(isJoined ? "Joined" : "Join Now"),
      ),
    );
  }
}
