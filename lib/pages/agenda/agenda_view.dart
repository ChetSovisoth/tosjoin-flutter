import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/base/res/app_styles.dart';
import 'package:tosjoin/pages/event_detail/event_detail_view.dart';

class AgendaView extends StatelessWidget {
  const AgendaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black, size: 35),
                  onPressed: () {
                    Get.to(() => const EventDetailView());
                  },
                ),
                Text(
                  "Agenda",
                  style: AppStyles.headingTextStyle,
                ),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.black, size: 35),
                  onPressed: () {
                    // Get.to(() => const EventDetailView());
                  },
                ),
              ],
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView(
                children: const [
                  Text("dasdas"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}