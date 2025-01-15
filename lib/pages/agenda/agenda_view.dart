import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/pages/home/event/event_detail.dart';

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
                    // Pass eventId and token when navigating to EventDetailView
                    Get.to(
                      () => EventDetailView(
                        eventId:
                            'your-event-id', // Replace with the actual event ID
                        token:
                            'your-auth-token', // Replace with the actual token
                      ),
                    );
                  },
                ),
                const Text(
                  "Agenda",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    // You can use your custom style here
                    // style: AppStyles.headingTextStyle,
                  ),
                ),
                IconButton(
                  icon:
                      const Icon(Icons.settings, color: Colors.black, size: 35),
                  onPressed: () {
                    // Navigate to settings screen
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsView()));
                    // or using GetX:
                    // Get.to(() => const SettingsView());
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: const [
                  // Add your list items here
                  // Example:
                  // ListTile(
                  //   title: Text('Event 1'),
                  //   subtitle: Text('10:00 AM - 11:00 AM'),
                  // ),
                  // ListTile(
                  //   title: Text('Event 2'),
                  //   subtitle: Text('11:00 AM - 12:00 PM'),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
