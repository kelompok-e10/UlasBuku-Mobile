import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ulasbuku_mobile/screens/login.dart';
import 'package:ulasbuku_mobile/screens/menu.dart';

import 'onboarding_screen2.dart';


class OnboardingScreen2 extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<OnboardingScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueAccent,
              Colors.lightBlueAccent,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/onboarding_screen2.jpeg",
                    height: 400,
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
            Container(
                alignment: Alignment.center,
                child: Column(
                 children: [
                   ElevatedButton(
                     onPressed: () {
                       Get.to(() => LoginPage(), transition: Transition.fade, duration: Duration(seconds: 2));
                     },
                     child: Text('Login'),
                   ),
                   SizedBox(height: 20),
                   ElevatedButton(
                     onPressed: () {
                       Get.to(() => MyHomePage(), transition: Transition.fade, duration: Duration(seconds: 2));
                     },
                     child: Text('Sign Up'),
                   ),
                 ],
                )
            )
          ],
        ),
      ),
    );
  }
}