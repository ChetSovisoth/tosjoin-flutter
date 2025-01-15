import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/base/app_style.dart';
import 'package:tosjoin/pages/agenda/agenda_view.dart';
import 'package:tosjoin/pages/home/event/event_controller.dart';
import 'package:tosjoin/pages/home/home_view.dart';
import 'package:tosjoin/pages/joined/join_controller.dart'; // Import JoinController
import 'package:tosjoin/pages/joined/join_view.dart';
import 'package:tosjoin/service/join_button.dart';

class EventDetailView extends StatelessWidget {
  final String eventId;
  final String token;
  final Map<String, dynamic> event;

  const EventDetailView({
    super.key,
    required this.eventId,
    required this.token,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final EventDetailController controller = Get.put(EventDetailController());
    final JoinController joinController =
        Get.put(JoinController()); // Initialize JoinController
    final halfScreenSize = MediaQuery.of(context).size.width / 2 - 10;

    controller.fetchEventDetails(eventId);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.eventDetailTitle.value.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView(
                    children: [
                      const SizedBox(height: 25),
                      // Picture
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                          image: DecorationImage(
                            image: NetworkImage(controller.image.value),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 10,
                              left: 15,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back,
                                      color: Colors.black),
                                  onPressed: () {
                                    Get.to(() => HomeView());
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 15,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.settings,
                                      color: Colors.black),
                                  onPressed: () {
                                    // Handle button press
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Text
                      Row(
                        children: [
                          Text(
                            controller.eventDetailTitle.value,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // Details
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: halfScreenSize,
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined,
                                        size: 35),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Location"),
                                        Text(controller.location.value,
                                            style: AppStyles.detailsTextStyle),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: halfScreenSize,
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_month_outlined,
                                        size: 35),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Date"),
                                        Text(controller.date.value,
                                            style: AppStyles.detailsTextStyle),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: halfScreenSize,
                                child: Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 35),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Timing"),
                                        Text(controller.timing.value,
                                            style: AppStyles.detailsTextStyle),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: halfScreenSize,
                                child: Row(
                                  children: [
                                    const Icon(Icons.person_add_alt, size: 35),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Attendance"),
                                        Text(
                                          controller.attendance.value,
                                          style: AppStyles.detailsTextStyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => AgendaView(
                                  eventId: eventId, // Pass the eventId
                                  token: token, // Pass the token
                                  event: event, // Pass the event data
                                ));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_today, size: 35),
                                    SizedBox(width: 10),
                                    Text("Agenda"),
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right_sharp, size: 35),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Description
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Description',
                              style: AppStyles.descriptionTextStyle),
                          ...controller.descriptions.map((text) => Text(text)),
                        ],
                      ),
                    ],
                  );
                }
              }),
            ),
            Obx(() => JoinButton(
                  event: {
                    'title': controller.eventDetailTitle.value,
                    'date': controller.date.value,
                    'location': controller.location.value,
                    'image': controller.image.value,
                  },
                  onJoinPressed: () {
                    final currentAttendance =
                        int.tryParse(controller.attendance.value) ?? 0;
                    final newAttendance = currentAttendance + 1;

                    // Update attendance count in local storage
                    controller.updateAttendance(eventId, newAttendance);

                    // Add event to joined events list
                    joinController.addEvent({
                      'title': controller.eventDetailTitle.value,
                      'date': controller.date.value,
                      'location': controller.location.value,
                      'image': controller.image.value,
                    });

                    // Show a success message
                    Get.snackbar(
                      'Success',
                      'You have joined the event!',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    Get.to(() => const JoinView());
                  },
                )),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
