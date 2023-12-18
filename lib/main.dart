// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ulasbuku_mobile/onboarding_screen/onboarding_screen1.dart';
import 'package:ulasbuku_mobile/screens/login.dart';
// import 'package:ulasbuku_mobile/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulasbuku_mobile/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        // Use the 'CookieRequest' class
        CookieRequest request = CookieRequest();
        return request;
      },
      child: GetMaterialApp(
          title: 'Ulas Buku Mobile',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromRGBO(135, 148, 192, 1.0)),
            useMaterial3: true,
          ),
          home: OnboardingScreen1()),
    );
  }
}
