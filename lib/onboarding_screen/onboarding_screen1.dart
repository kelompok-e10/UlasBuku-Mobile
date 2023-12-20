import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'onboarding_screen2.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<OnboardingScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
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
                  Image.asset(
                    "assets/onboarding_image1.png",
                    height: 350,
                  ),
                  const Text(
                    "Selamat Datang di UlasBuku!",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
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
                  onTap: () {
                    Get.to(() => const OnboardingScreen2(),
                        transition: Transition.fadeIn,
                        duration: const Duration(seconds: 1));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => const OnboardingScreen2(),
                              transition: Transition.fade,
                              duration: const Duration(seconds: 1));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
