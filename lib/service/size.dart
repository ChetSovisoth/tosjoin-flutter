import 'dart:math';

import 'package:flutter/material.dart';

const double kPadding = 8.0;
const double kSpace = 8.0;
const double kMargin = 8.0;
const double kBorderRadius = 8.0;
const double kBorderWidth = 1.0;
const double kElevation = 8.0;
const double kIconSize = 24.0;
const double kFontSize = 16.0;
const double kHeight = 8.0;
const double kWidth = 8.0;


class ScaleSize {
  static double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
