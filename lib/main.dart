// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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
      child: MaterialApp(
          title: 'Ulas Buku Mobile',
          theme: ThemeData(
<<<<<<< HEAD
            colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromRGBO(135, 148, 192, 1.0)),
            useMaterial3: true,
=======
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(1, 1, 1, 0.8)),            useMaterial3: true,
>>>>>>> 7c4a4f08a1f7e5896a93a9353b0cdc632e413a5a
          ),
          home: LoginPage()),
    );
  }
}
