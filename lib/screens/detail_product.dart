import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ulasbuku_mobile/models/book.dart';
import 'package:ulasbuku_mobile/widgets/left_drawer.dart';
import 'package:ulasbuku_mobile/screens/see_products.dart';


class DetailProductPage extends StatelessWidget {
  const DetailProductPage({Key? key, required this.id}) : super(key: key);
  final int id;

  Future<List<Book>> fetchProduct() async {
    var url = Uri.parse(
        'http://127.0.0.1:8000/json/${id}');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Book> list_product = [];
    for (var d in data) {
      if (d != null) {
        list_product.add(Book.fromJson(d));
      }
    }
    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Product'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data produk.",
                        style:
                        TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.data![index].fields.bookTitle}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("Author: ${snapshot.data![index].fields.bookAuthor}"),
                            const SizedBox(height: 10),
                            Text("Published on: ${snapshot.data![index].fields.yearOfPublication}"),
                            const SizedBox(height: 10),
                            // Text(
                            //     "${snapshot.data![index].fields.publisher}"),
                            ElevatedButton(
                              onPressed: () async {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ProductPage()),
                                );
                              },
                              child: const Text('Kembali'),
                            ),
                          ],
                        ),
                      ));
                }
              }
            }));
  }
}