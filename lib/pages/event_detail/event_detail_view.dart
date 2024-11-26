import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosjoin/base/res/app_styles.dart';
import 'package:tosjoin/pages/agenda/agenda_view.dart';
import 'package:tosjoin/pages/home/home_view.dart';
import 'package:tosjoin/pages/event_detail/event_detail_controller.dart';

class EventDetailView extends StatelessWidget {
  const EventDetailView({super.key});
  @override
  Widget build(BuildContext context) {

  final halfScreenSize =  MediaQuery.of(context).size.width / 2 - 10;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 25),
                  //Picture
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      image: DecorationImage(
                        image: AssetImage(EventDetailController.image),
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
                              icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                              icon: const Icon(Icons.settings, color: Colors.black),
                              onPressed: () {
                                // Handle button press
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Text
                  const Row(
                    children: [
                      Text(
                        EventDetailController.eventDetailTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  //Details
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:  halfScreenSize, // Set a consistent width for alignment
                            child: Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 35),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Location"),
                                    Text(EventDetailController.location, style: AppStyles.detailsTextStyle),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: halfScreenSize, // Set a consistent width for alignment
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_month_outlined, size: 35),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Date"),
                                    Text(EventDetailController.date, style: AppStyles.detailsTextStyle),
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
                            width: halfScreenSize, // Set a consistent width for alignment
                            child: Row(
                              children: [
                                const Icon(Icons.access_time, size: 35),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Timing"),
                                    Text(EventDetailController.timing, style: AppStyles.detailsTextStyle),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: halfScreenSize, // Set a consistent width for alignment
                            child: Row(
                              children: [
                                const Icon(Icons.person_add_alt, size: 35),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Attendance"),
                                    Text(EventDetailController.attendance, style: AppStyles.detailsTextStyle),
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

                  //Agenda
                  Container(
                    // color: AppStyles.bgColor, // Set your background color
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        // Handle the button tap here
                        Get.to(() => const AgendaView());
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

                  //Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description', style: AppStyles.descriptionTextStyle),
                      ...EventDetailController.descriptions.map((text) => Text(text)),
                      ...EventDetailController.descriptions.map((text) => Text(text)),
                      ...EventDetailController.descriptions.map((text) => Text(text)),
                      ...EventDetailController.descriptions.map((text) => Text(text))
                    ],
                  ),
                ],
              ),
            ),

            //Button
            const JoinButton(),

            const SizedBox(height: 5)
          ],
        ),
      ),
    );
  }
}

class JoinButton extends StatefulWidget {
  const JoinButton({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JoinButtonState createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
  bool isJoined = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          setState(() {
            isJoined = !isJoined; // Toggle state
          });
        },
        style: isJoined ? AppStyles.grayButtonStyle : AppStyles.blueButtonStyle,
        child: Text(
          isJoined ? "Joined" : "Join Now"
        ), // Display updated text
      ),
    );
  }
}