// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ulasbuku_mobile/screens/menu.dart';
import 'package:ulasbuku_mobile/screens/see_books.dart';
import 'package:ulasbuku_mobile/forum_diskusi/screen/see_forums.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromRGBO(135, 148, 192, 1.0), // Background color of the drawer
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(1, 1, 1, 0.8), // Header color
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Logo UlasBuku.png', // Update the image asset path
                    height: 30, // Adjust the height as needed
                  ),
                  Padding(
                    padding: EdgeInsets.all(10)),
                ],
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
                'Lihat Buku',
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
              leading: const Icon(Icons.chat),
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
                  MaterialPageRoute(builder: (context) => const ForumPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                    ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForumPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
