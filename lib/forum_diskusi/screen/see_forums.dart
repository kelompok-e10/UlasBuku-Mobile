// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ulasbuku_mobile/forum_diskusi/model/forum.dart';
import 'package:ulasbuku_mobile/forum_diskusi/screen/forum_form.dart';
import 'package:ulasbuku_mobile/widgets/left_drawer.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  Future<List<Forum>> fetchForum() async {
    var url = Uri.parse(
        'http://127.0.0.1:8000/forum_discussion/get_header_json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // print(response.body);

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Forum> listForum = [];
    for (var d in data) {
      if (d != null) {
        listForum.add(Forum.fromJson(d));
      }
    }
    return listForum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(135, 148, 192, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 1, 1, 0.8),
        title: const Text(
          'Forum Diskusi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: fetchForum(),
              builder: (context, AsyncSnapshot<List<Forum>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Tidak ada data forum.',
                      style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    padding: const EdgeInsets.all(20.0),
                    color: Color.fromRGBO(234, 242, 215, 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${snapshot.data![index].bookInfo.bookTitle}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Image.network("${snapshot.data![index].bookInfo.imageUrlS}"),
                        const SizedBox(height: 10),
                        Text("${snapshot.data![index].rating}"),
                        const SizedBox(height: 10),
                        Text("${snapshot.data![index].review}"),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ForumFormPage()),
                );
              },
              child: const Text('Tambahkan Diskusi'),
            ),
          ),
        ],
      ),
    );
  }
}