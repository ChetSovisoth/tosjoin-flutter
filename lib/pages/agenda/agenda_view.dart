import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgendaView extends StatelessWidget {
  const AgendaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.black, size: 35),
                  onPressed: () {
                    // Get.to(() => const EventDetailView());
                  },
                ),
                Text(
                  "Agenda",
                  // style: AppStyles.headingTextStyle,
                ),
                IconButton(
                  icon:
                      const Icon(Icons.settings, color: Colors.black, size: 35),
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
                  Column(
                    children: [],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
