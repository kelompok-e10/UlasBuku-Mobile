import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ulasbuku_mobile/models/book.dart';
import 'package:ulasbuku_mobile/screens/detail_book.dart';
import 'package:ulasbuku_mobile/widgets/left_drawer.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();

  void navigateToDetailPage(Book book, BuildContext context) {
    // Changed from _navigateToDetailPage to navigateToDetailPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(book: book),
      ),
    );
  }
}

class _ProductPageState extends State<ProductPage> {
  final List<Book> _books = [];
  int _currentPage = 1;
  final int _perPage = 10;

  // Fetch books from the API
  Future<void> fetchProduct() async {
    var url = Uri.parse('https://ulasbuku-e10-tk.pbp.cs.ui.ac.id/api/books/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Book> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(Book.fromJson(d));
      }
    }

    // Only take the first 10 books
    listProduct =
        listProduct.skip((_currentPage - 1) * _perPage).take(_perPage).toList();

    setState(() {
      _books.addAll(listProduct);
      _currentPage++;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lihat Buku'),
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _books.length,
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () {
                    widget.navigateToDetailPage(_books[index], context);
                  },
                  child: Card(
                    color: Colors.accents[index % 10], // Add this
                    elevation: 5,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _books[index].fields.bookTitle,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(_books[index].fields.bookAuthor),
                          const SizedBox(height: 10),
                          Text("${_books[index].fields.yearOfPublication}"),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookDetailPage(book: _books[index]),
                                ),
                              );
                            },
                            child: const Text('See Details'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: fetchProduct,
                child: const Text('Load more'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
