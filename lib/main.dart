import 'package:flutter/material.dart';
import 'package:ulasbuku_mobile/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UlasBuku Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(135, 148, 192, 1.0)),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}