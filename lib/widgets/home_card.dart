// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ulasbuku_mobile/profile_page/screen/see_profile.dart';
import 'package:ulasbuku_mobile/screens/menu.dart';
import 'package:ulasbuku_mobile/screens/see_books.dart';
import 'package:ulasbuku_mobile/forum_diskusi/screen/see_forums.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulasbuku_mobile/screens/login.dart';
import 'package:ulasbuku_mobile/screens/search_book.dart';

import '../send_messages/pages/users_page.dart';

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
          if (item.name == "Lihat Profile") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          } else if (item.name == "Forum Diskusi") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ForumPage()));
          } else if (item.name == "Lihat Buku") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProductPage()));
          } else if (item.name == "Cari Buku") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BookSearchPage()));
          } else if (item.name == "Pesan") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home()));
          } else if (item.name == "Logout") {
            final response =
                await request.logout("https://ulasbuku-e10-tk.pbp.cs.ui.ac.id/auth/logout/");
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
