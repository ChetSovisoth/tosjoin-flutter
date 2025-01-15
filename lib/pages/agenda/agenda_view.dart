import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:tosjoin/base/app_style.dart';
import 'package:tosjoin/pages/agenda/agenda_controller.dart';

class AgendaView extends StatelessWidget {
  final String eventId;
  final String token;
  final Map<String, dynamic> event;

  const AgendaView({
    super.key,
    required this.eventId,
    required this.token,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Add a header or other widgets here
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 30),
                onPressed: () {
                  Get.back(); // Navigate back to the previous screen
                },
              ),
              const Text(
                'Agenda',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.settings, size: 30),
                onPressed: () {
                  // Handle settings
                },
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Expanded to allow Timeline to take up remaining space
          Expanded(
            child: ListView.builder(
              itemCount: AgendaController.agendaTimelineCount,
              itemBuilder: (context, index) {
                return TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.2, // Adjust the position of the line
                  isFirst: index == 0,
                  isLast: index == AgendaController.agendaTimelineCount - 1,
                  beforeLineStyle: const LineStyle(
                    color: Colors.grey, // Customize the line color
                    thickness: 2, // Customize the line thickness
                  ),
                  indicatorStyle: IndicatorStyle(
                    width: 20,
                    height: 20,
                    indicator: Container(
                      decoration: BoxDecoration(
                        color: AppStyles.progressColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  startChild: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AgendaController.agendaTime[index],
                      style: AppStyles.agendaDescriptionTextStyle,
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AgendaController.agendaTitle[index],
                          style: AppStyles.agendaTitleTextStyle,
                        ),
                        Text(
                          AgendaController.agendaDescription[index],
                          style: AppStyles.agendaDescriptionTextStyle,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
