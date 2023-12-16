// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:ulasbuku_mobile/screens/menu.dart';
import 'package:ulasbuku_mobile/screens/see_books.dart';
import 'package:ulasbuku_mobile/forum_diskusi/screen/see_forums.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulasbuku_mobile/screens/login.dart';

import '../send_messages/pages/users_page.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      child: Container(
        color: const Color.fromRGBO(135, 148, 192, 1.0), // Background color of the drawer
        child: ListView(
          children: [
             UserAccountsDrawerHeader(
              accountName: Text(LoggedIn.user_data['username']!),
              accountEmail: const Text(""),
              currentAccountPicture: const CircleAvatar(
                  child: Icon(
                    Icons.account_circle,
                  )
              ),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              image: DecorationImage(image: AssetImage('assets/background.png'), fit: BoxFit.cover)
            ),
          ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text(
                'Tentang',
                style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                    ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.forum_rounded),
              title: const Text(
                'Forum Diskusi',
                style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                    ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForumPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(
                'Daftar Buku',
                style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                    ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text(
                'Pesan',
                style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                    ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async{
              final response = await request.logout(
                  "http://127.0.0.1:8000/auth/logout/");
              String message = response["message"];
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message Terima kasih sudah berkunjung, $uname"),
                ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message"),
                ));
              }
              },
            ),
          ],
        ),
      ),

    );
  }
}
