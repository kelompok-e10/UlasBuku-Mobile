import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulasbuku_mobile/onboarding_screen/onboarding_screen1.dart';
import 'package:ulasbuku_mobile/screens/login.dart';
import 'package:ulasbuku_mobile/screens/register.dart';



class OnboardingScreen2 extends StatefulWidget {
  const OnboardingScreen2({super.key});

  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<OnboardingScreen2> {
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
              Colors.blueAccent,
              Colors.lightBlueAccent,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: (){
                  Get.to(() => const OnboardingScreen1(), transition: Transition.fade, duration: const Duration(seconds: 1));
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 30.0, top: 30), // Tambahkan ruang di sebelah kiri ikon
                  child: Row(
                    children: [
                      Icon(
                        color: Colors.white,
                        Icons.arrow_back,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Prev',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    "assets/onboarding_image2.png",
                    height: 350,
                  ),
                
                  const Text(
                    "Bergabung Sekarang di UlasBuku!",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                ],
              ),
            ),
        
            Container(
                alignment: Alignment.center,
                child: Column(
                 children: [
                   ElevatedButton(
                     onPressed: () {
                        Get.to(() => const LoginPage(), transition: Transition.fadeIn, duration: const Duration(seconds: 1));
                     },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent, 
                      ),
                     child: const Text('Login',
                      style: TextStyle(color: Colors.white) 
                     ),
                   ),
                   const SizedBox(height: 15),
                   ElevatedButton(
                     onPressed: () {
                       Get.to(() => const RegisterPage(), transition: Transition.fadeIn, duration: const Duration(seconds: 1));
                     },
                     style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent, 
                      ),
                     child: const Text('Sign Up',
                      style: TextStyle(color: Colors.white),
                      ),
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