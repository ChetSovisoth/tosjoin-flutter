import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tosjoin/service/color.dart';
import 'package:tosjoin/service/size.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          size: kIconSize * 1.4,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
