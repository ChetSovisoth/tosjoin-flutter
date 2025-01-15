import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:get/get.dart';
import 'package:tosjoin/base/res/app_styles.dart';
import 'package:tosjoin/pages/agenda/agenda_controller.dart';
import 'package:tosjoin/pages/event_detail/event_detail_view.dart';

class AgendaView extends StatelessWidget {
  const AgendaView({super.key});

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
                  Get.to(() => const EventDetailView());
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
            child: Timeline.tileBuilder(
              theme: TimelineThemeData(
                connectorTheme: ConnectorThemeData(
                  thickness: 5.0,
                  color: AppStyles.progressColor,
                ),
                indicatorTheme: IndicatorThemeData(
                  size: 20.0,
                  color: AppStyles.progressColor
                ),
              ),
              builder: TimelineTileBuilder.fromStyle(
                indicatorStyle: IndicatorStyle.dot,
                contentsAlign: ContentsAlign.reverse,
                contentsBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AgendaController.agendaTime[index],
                    style: AppStyles.agendaDescriptionTextStyle,
                  ),
                ),
                oppositeContentsBuilder: (context, index) => Padding(
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
                      )
                    ],
                  )
                ),
                itemCount: AgendaController.agendaTimelineCount,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
