import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'onboarding_screen2.dart';


class OnboardingScreen1 extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<OnboardingScreen1> {
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
              Colors.blueAccent, // Warna ungu terang
              Colors.lightBlueAccent, // Warna biru terang
              Colors.white, // Warna biru muda
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
                    "assets/onboarding_screen1.jpeg",
                    height: 300,
                  ),
                  Text(
                    "Selamat Datang di UlasBuku!",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Jelajahi dunia literasi bersama UlasBuku",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: (){
                  Get.to(() => OnboardingScreen2, transition: Transition.fade,
                  duration: Duration(seconds: 2));
                },
                child: Row(
                  children: [
                    Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.grey,
                      )
                    ),
                    SizedBox(width: 10,),
                    Icon(
                      Icons.arrow_right_outlined,
                      color: Colors.grey,
                    )
                  ],
                )
              )
            )
          ],
        ),
      ),
    );
  }
}