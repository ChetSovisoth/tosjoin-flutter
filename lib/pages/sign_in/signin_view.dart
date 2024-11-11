// import 'package:des_app/core/color.dart';
// import 'package:des_app/core/size.dart';
// import 'package:des_app/pages/sign_in/signin_controller.dart';
// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';

// class SignInView extends GetView<SignInController> {
//   const SignInView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: true,
//       child: Scaffold(
//           appBar: AppBar(
//             leading: const SizedBox(),
//           ),
//           body: Padding(
//             padding: EdgeInsets.only(top: Get.context!.isLandscape ? 0 : Get.height * 0.20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image(
//                     image: const AssetImage("assets/logo.png"),
//                     width: Get.width * 0.5),
//                 const Gap(kSpace),
//                 const Text(
//                   "Welcome",
//                   style: TextStyle(
//                     fontSize: kFontSize * 1.5,
//                     color: kPrimaryColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Gap(kSpace),
//                 const Text("Create an account and access thoudands"),
//                 const Text("of cool stuff"),
//                 const Gap(kSpace),
//                 Container(
//                   width: double.infinity,
//                   height: Get.height * 0.055,
//                   padding: EdgeInsets.symmetric(horizontal: Get.width * 0.12),
//                   child: TextButton(
//                     onPressed: controller.onJoinWithGoogle,
//                     style: TextButton.styleFrom(
//                       backgroundColor: kPrimaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(kBorderRadius),
//                       ),
//                     ),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(EvaIcons.google, color: Colors.white),
//                         Gap(kSpace),
//                         Text(
//                           "Continues with Google",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: kFontSize * 0.9,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const Gap(kSpace),
//                 Visibility(
//                   visible: GetPlatform.isIOS,
//                   child: Container(
//                     width: double.infinity,
//                     height: Get.height * 0.055,
//                     padding: EdgeInsets.symmetric(horizontal: Get.width * 0.12),
//                     child: TextButton(
//                       onPressed: controller.onJoinWithApple,
//                       style: TextButton.styleFrom(
//                         backgroundColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(kBorderRadius),
//                         ),
//                       ),
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Icon(Icons.apple, color: Colors.white),
//                           Gap(kSpace),
//                           Text(
//                             "Continues with Apple",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: kFontSize * 0.9,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//       ),
//     );
//   }
// }
