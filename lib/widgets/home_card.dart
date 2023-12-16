// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ulasbuku_mobile/screens/landing_page/menu.dart';
import 'package:ulasbuku_mobile/screens/see_books.dart';
import 'package:ulasbuku_mobile/screens/forum_diskusi/see_forums.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulasbuku_mobile/screens/landing_page/login.dart';

class UlasBukuCard extends StatelessWidget {
  final UlasBukuItems item;

  const UlasBukuCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    var buttonColor = Colors.white;

    return Material(
      color: buttonColor,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () async {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}")));
          if (item.name == "Forum Diskusi") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ForumPage()));
          }
          else if (item.name == "Lihat Buku") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BookPage()));
          }
          else if (item.name == "Pesan") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ForumPage()));
          }
          else if (item.name == "Logout") {
            final response = await request.logout(
                "http://10.0.2.2:8000/auth/logout/");
            String message = response["message"];
            if (response['status']) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message),
              ));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message),
              ));
            }
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.black,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}