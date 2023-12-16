// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ulasbuku_mobile/models/book.dart';
import 'package:ulasbuku_mobile/screens/detail_product.dart';
import 'package:ulasbuku_mobile/widgets/left_drawer.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  Future<List<Book>> fetchProduct() async {
    var url = Uri.parse(
        'http://127.0.0.1:8000/forum_discussion/get_header_json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Book> list_Book = [];
    for (var d in data) {
      if (d != null) {
        list_Book.add(Book.fromJson(d));
      }
    }
    return list_Book;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromRGBO(135, 148, 192, 1.0),
      appBar: AppBar(
        backgroundColor:Color.fromRGBO(1, 1, 1, 0.8),
        title: const Text(
          'Lihat Buku',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
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
                            Text("${snapshot.data![index].fields.bookAuthor}"),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.yearOfPublication}"),
                            const SizedBox(height: 10),

                            ElevatedButton(
                              onPressed: () async {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => DetailProductPage(id: snapshot.data![index].pk)),
                                );
                              },
                              child: const Text('Detail Buku'),
                            ),
                          ],
                        ),
                      ));
                }
              }
            }));
  }
}