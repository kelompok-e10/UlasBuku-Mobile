import 'package:flutter/material.dart';
import 'package:ulasbuku_mobile/profile_page/screen/see_profile.dart';
import 'package:ulasbuku_mobile/screens/menu.dart';
import 'package:ulasbuku_mobile/screens/shoplist_form.dart';
import 'package:ulasbuku_mobile/screens/see_books.dart';
import 'package:ulasbuku_mobile/forum_diskusi/screen/see_forums.dart';
import 'package:ulasbuku_mobile/send_messages/pages/users_page.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(1, 1, 1, 0.8),
            ),
            child: Column(
              children: [
                Text(
                  'Ulas Buku Mobile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Cari Produk'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductSearchPage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Lihat Produk'),
            onTap: () {
              // Route menu ke halaman produk
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Forum Diskusi'),
            onTap: () {
              // Route menu ke halaman forum
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForumPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Pesan'),
            onTap: () {
              // Route menu ke halaman pesan
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
          ),
        ],
      ),
    );
  }
}
