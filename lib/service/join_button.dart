import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/pages/joined/join_controller.dart';
import '../../../base/app_style.dart';

class JoinButton extends StatefulWidget {
  final Map<String, String> event;

  const JoinButton({super.key, required this.event});

  @override
  _JoinButtonState createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
  final JoinController _joinController =
      Get.put(JoinController()); // Initialize here
  bool isJoined = false;

  @override
  void initState() {
    super.initState();
    // Check if the event is already joined
    isJoined = _joinController.isEventJoined(widget.event['title']!);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          setState(() {
            isJoined = !isJoined; // Toggle state
            if (isJoined) {
              _joinController
                  .addEvent(widget.event); // Add event to joined list
            } else {
              _joinController
                  .removeEvent(widget.event['title']!); // Remove event
            }
          });
        },
        style: isJoined ? AppStyles.grayButtonStyle : AppStyles.blueButtonStyle,
        child: Text(isJoined ? "Joined" : "Join Now"), // Display updated text
      ),
    );
  }
}
