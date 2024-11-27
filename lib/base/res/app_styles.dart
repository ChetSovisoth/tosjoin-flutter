import 'package:flutter/material.dart';

class AppStyles {
  static Color bgColor = const Color.fromRGBO(147, 147, 147, 1);
  static Color blueColor = const Color.fromRGBO(57, 47, 162, 1);
  static Color progressColor = const Color.fromRGBO(18, 109, 160, 1);

  static TextStyle detailsTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500, 
    color: blueColor
  );

  static TextStyle descriptionTextStyle = const TextStyle(
    fontSize: 18, 
    fontWeight: FontWeight.w600, 
    color: Color.fromRGBO(84, 95, 113, 1)
  );

  static TextStyle headingTextStyle = const TextStyle(
    fontSize: 20, 
    fontWeight: FontWeight.w500, 
    color: Colors.black
  );

  static final ButtonStyle blueButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: blueColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  static final ButtonStyle grayButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color.fromRGBO(84, 95, 113, 1),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  static TextStyle agendaTitleTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: progressColor
  );

  static TextStyle agendaDescriptionTextStyle = const TextStyle(
      fontSize: 15,
      color: Color.fromRGBO(84, 95, 113, 1)
  );
}