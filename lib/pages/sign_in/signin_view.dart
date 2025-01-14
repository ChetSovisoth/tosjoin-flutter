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

//login

import 'package:flutter/material.dart';
import 'package:tosjoin/base/res/app_styles.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  // Your onPressed action here
                },
                icon: const Text(
                  '←',
                  style: TextStyle(fontSize: 35), // Adjust font size as needed
                ),
              ),
            ],
          ),
        ),
        // const SizedBox(height: 60),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Log In Now",
              style: TextStyle(
                  fontSize: 28,
                  color: AppStyles.primary,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Please login to continuous using our app ",
              style: TextStyle(fontSize: 14, color: AppStyles.gray),
            )
          ],
        ),
        const SizedBox(height: 80),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                // controller: bloc.nameController,
                decoration: const InputDecoration(
                  hintText: "Email",
                  filled: true,
                  fillColor: AppStyles.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyles.black,
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                // controller: bloc.nameController,
                decoration: const InputDecoration(
                  hintText: "Password",
                  filled: true,
                  fillColor: AppStyles.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyles.black,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Forgot Password",
                style: TextStyle(
                    fontSize: 13,
                    color: AppStyles.primary,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 350,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppStyles.primary,
            ),
            onPressed: () {
              // bloc.add(const CommentSubmitted());
            },
            child: const Text(
              "Sign In",
              style: TextStyle(
                fontSize: 16,
                color: AppStyles.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don’t have an account ?",
              style: TextStyle(
                  fontSize: 13,
                  color: AppStyles.gray,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Sign up",
              style: TextStyle(
                  fontSize: 13,
                  color: AppStyles.primary,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 80),
        const Text(
          "or connect with",
          style: TextStyle(
              fontSize: 13, color:AppStyles.gray, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // const Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     Icon(
        //       Icons.facebook,
        //       color: AppStyles.primary,
        //       size: 60,
        //     ),
        //     Icon(
        //       Icons.facebook,
        //       color: AppStyles.primary,
        //       size: 60,
        //     ),
        //     Icon(
        //       Icons.facebook,
        //       color: AppStyles.primary,
        //       size: 60,
        //     )
        //   ],
        // )
      ],
    );
  }
}
