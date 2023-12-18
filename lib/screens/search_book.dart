import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:ulasbuku_mobile/models/book.dart';
import 'package:http/http.dart' as http;

class BookSearchPage extends StatefulWidget {
  BookSearchPage({Key? key}) : super(key: key);

  @override
  _BookSearchPageState createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  List<Book> _books = [];
  List<Book> _filteredBooks = [];
  bool _sortTitleAscending = true;
  bool _sortIsbnAscending = true;
  bool _sortAuthorAscending = true;
  bool _sortYearAscending = true;
  String _currentSearchTerm = '';

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
    setState(() {
      _books = listProduct;
      _filteredBooks = List.from(_books);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  void filterBooks(value) {
    _currentSearchTerm = value;
    setState(() {
      _filteredBooks = _books
          .where((book) =>
              book.fields.bookTitle
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              book.fields.isbn.toLowerCase().contains(value.toLowerCase()) ||
              book.fields.bookAuthor
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              book.fields.yearOfPublication
                  .toString()
                  .contains(value.toLowerCase()))
          .toList();
    });
  }

  void sortBooksByAuthor() {
    setState(() {
      _filteredBooks.sort((a, b) =>
          a.fields.bookAuthor.compareTo(b.fields.bookAuthor) *
          (_sortAuthorAscending ? 1 : -1));
      _sortAuthorAscending = !_sortAuthorAscending;
    });
  }

  void sortBooksByYear() {
    setState(() {
      _filteredBooks.sort((a, b) =>
          a.fields.yearOfPublication.compareTo(b.fields.yearOfPublication) *
          (_sortYearAscending ? 1 : -1));
      _sortYearAscending = !_sortYearAscending;
    });
  }

  void sortBooksByTitle() {
    setState(() {
      _filteredBooks.sort((a, b) =>
          a.fields.bookTitle.compareTo(b.fields.bookTitle) *
          (_sortTitleAscending ? 1 : -1));
      _sortTitleAscending = !_sortTitleAscending;
    });
  }

  void sortBooksByIsbn() {
    setState(() {
      _filteredBooks.sort((a, b) =>
          a.fields.isbn.compareTo(b.fields.isbn) *
          (_sortIsbnAscending ? 1 : -1));
      _sortIsbnAscending = !_sortIsbnAscending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: filterBooks,
          decoration: const InputDecoration(
            hintText: 'Search by title, ISBN, author, or year',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.sort_by_alpha), // Changed icon
            onPressed: sortBooksByTitle,
          ),
          IconButton(
            icon: Icon(Icons.numbers), // Changed icon
            onPressed: sortBooksByIsbn,
          ),
          IconButton(
            icon: Icon(Icons.person), // Changed icon
            onPressed: sortBooksByAuthor,
          ),
          IconButton(
            icon: Icon(Icons.calendar_today), // Changed icon
            onPressed: sortBooksByYear,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${_filteredBooks.length} results for "$_currentSearchTerm"',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredBooks.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5, // Adds shadow
                  shape: RoundedRectangleBorder(
                    // Adds border
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.2), // Border color
                      width: 1, // Border width
                    ),
                  ),
                  child: ListTile(
                    title: Text(_filteredBooks[index].fields.bookTitle),
                    subtitle: Text('${_filteredBooks[index].fields.isbn}\n'
                        'Author: ${_filteredBooks[index].fields.bookAuthor}\n'
                        'Year: ${_filteredBooks[index].fields.yearOfPublication}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
