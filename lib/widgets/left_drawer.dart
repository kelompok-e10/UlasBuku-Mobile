// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ulasbuku_mobile/profile_page/screen/see_profile.dart';

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
        color: Color.fromRGBO(135, 148, 192, 1.0), // Background color of the drawer
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
              color: Color.fromRGBO(1, 1, 1, 0.8),
              image: DecorationImage(
                image: AssetImage('assets/background.png'), 
                fit: BoxFit.cover)
            ),
          ),
            ListTile(
              leading: const Icon(Icons.home_outlined, color: Colors.black),
              title: const Text(
                'Tentang',
                style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
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
              leading: const Icon(Icons.forum_rounded, color: Colors.black),
              title: const Text(
                'Profile',
                style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.forum_rounded, color: Colors.black),
              title: const Text(
                'Forum Diskusi',
                style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    ),
              onTap: () {
                Navigator.pushReplacement(
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Cari Buku'),
            // Bagian redirection ke ShopFormPage
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
              leading: const Icon(Icons.book, color: Colors.black),
              title: const Text(
                'Daftar Buku',
                style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
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
              leading: const Icon(Icons.message, color: Colors.black),
              title: const Text(
                'Pesan',
                style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
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
              leading: const Icon(Icons.logout, color: Colors.black),
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
                  content: Text(message),
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

                    builder: (context) => ProductSearchPage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_basket),
            title: const Text('Lihat Buku'),
            onTap: () {
              // Route menu ke halaman Buku
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
