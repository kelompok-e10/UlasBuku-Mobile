import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ulasbuku_mobile/models/book.dart';
import 'dart:ui' as ui;
import 'dart:async';

class ProductDetailPage extends StatefulWidget {
  final Book product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  double _opacity = 0.0;

  Future<ui.Image> _getImage(String url) {
    Image image = Image.network(url);
    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image.resolve(ImageConfiguration()).addListener(
          ImageStreamListener(
            (ImageInfo info, bool _) => completer.complete(info.image),
          ),
        );
    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Book'),
      ),
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(seconds: 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: FutureBuilder<ui.Image>(
                  future: _getImage(widget.product.fields.imageUrlS),
                  builder:
                      (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      double screenWidth = MediaQuery.of(context).size.width;
                      double screenHeight = MediaQuery.of(context).size.height;

                      return Container(
                        width: snapshot.data!.width == 1 &&
                                snapshot.data!.height == 1
                            ? screenWidth * 0.10
                            : null,
                        height: snapshot.data!.width == 1 &&
                                snapshot.data!.height == 1
                            ? screenHeight * 0.30
                            : null,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 3,
                          ),
                        ),
                        child: (snapshot.data!.width == 1 &&
                                snapshot.data!.height == 1)
                            ? const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('No Image Available'),
                              )
                            : Image.network(
                                widget.product.fields.imageUrlS,
                                fit: BoxFit.cover,
                              ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title: ${widget.product.fields.bookTitle}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Author: ${widget.product.fields.bookAuthor}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Year of Publication: ${widget.product.fields.yearOfPublication}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Publisher: ${widget.product.fields.publisher}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'ISBN: ${widget.product.fields.isbn}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // background color
                          foregroundColor: Colors.white, // text color
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Go back'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
