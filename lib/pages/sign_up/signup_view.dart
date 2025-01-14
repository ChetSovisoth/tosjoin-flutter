//register 

import 'package:flutter/material.dart';
import 'package:tosjoin/base/res/app_styles.dart';
// import 'package:project_flutter/themes/appcolor.dart';

class Register extends StatelessWidget {
  const Register({super.key});

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
                  hintText: "Username",
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
                  hintText: "Email",
                  filled: true,
                  fillColor:AppStyles.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color:AppStyles.black,
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
                    color:AppStyles.primary,
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
              fontSize: 13, color: AppStyles.gray, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // const Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     Icon(
        //       Icons.facebook,
        //       color:AppStyles.primary,
        //       size: 60,
        //     ),
        //     Icon(
        //       Icons.facebook,
        //       color:AppStyles.primary,
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
