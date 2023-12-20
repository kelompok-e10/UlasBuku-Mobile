import 'package:flutter/material.dart';
import 'package:ulasbuku_mobile/widgets/left_drawer.dart';
import 'package:ulasbuku_mobile/widgets/home_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<UlasBukuItems> items = [
    UlasBukuItems("Lihat Profile", Icons.person),
    UlasBukuItems("Forum Diskusi", Icons.forum_rounded),
    UlasBukuItems("Lihat Buku", Icons.book),
    UlasBukuItems("Cari Buku", Icons.search),
    UlasBukuItems("Pesan", Icons.message),
    UlasBukuItems("Log Out", Icons.logout)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(135, 148, 192, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(1, 1, 1, 0.8),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/UlasBuku.png', // Replace with your image path
                width: 40,
                height: 40,
              ),
            ),
            const Text(
              'UlasBuku',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
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
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 4,
                shrinkWrap: true,
                children: items.map((UlasBukuItems item) {
                  // Iterasi untuk setiap item
                  return UlasBukuCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UlasBukuItems {
  final String name;
  final IconData icon;

  UlasBukuItems(this.name, this.icon);
}
