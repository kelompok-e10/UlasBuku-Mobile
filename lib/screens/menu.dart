import 'package:flutter/material.dart';
import 'package:ulasbuku_mobile/widgets/left_drawer.dart';
import 'package:ulasbuku_mobile/widgets/shop_card.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<ShoplistItem> items = [
    ShoplistItem("Cari Item", Icons.checklist),
    ShoplistItem("Lihat Item", Icons.add_shopping_cart),
    ShoplistItem("Logout", Icons.logout),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(135, 148, 192, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(1, 1, 1, 0.8),
        title: const Text(
          'UlasBuku',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Rekomendasi buku untuk kamu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Text(
                'Tentukan inspirasi bacamu segera!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ShoplistItem item) {
                  // Iterasi untuk setiap item
                  return ShoplistCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShoplistItem {
  final String name;
  final IconData icon;

  ShoplistItem(this.name, this.icon);
}
