// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ulasbuku_mobile/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulasbuku_mobile/screens/menu.dart';
import 'dart:convert';

class ForumFormPage extends StatefulWidget {
  const ForumFormPage({super.key});

  @override
  State<ForumFormPage> createState() => _ForumFormPageState();
}

class _ForumFormPageState extends State<ForumFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _bookTitle = "";
  int _rating = 0;
  String _review = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor:Color.fromRGBO(135, 148, 192, 1.0),
      appBar: AppBar(
        backgroundColor:Color.fromRGBO(1, 1, 1, 0.8),
        title: const Text(
          'Form Tambah Diskusi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFFFFFFF)),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Judul Buku",
                        labelText: "Judul Buku",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _bookTitle = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Judul buku tidak boleh kosong!";
                        }
                        return null;
                      },
                    ),
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFFFFFFF)),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Rating (dari 1-5)",
                        labelText: "Rating (dari 1-5)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _rating = int.parse(value!);
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Rating tidak boleh kosong!";
                        }
                        if (int.tryParse(value) == null) {
                          return "Rating harus berupa angka!";
                        }
                        if (_rating < 1 || _rating > 5) {
                          return "Rating hanya boleh di angka antara 1 sampai 5!";
                        }
                        return null;
                      },
                    ),
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFFFFFFF)),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Ulasan",
                        labelText: "Ulasan",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onChanged: (String value) {
                        setState(() {
                          _review = value;
                        });
                      },
                    ),
                  ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.indigo),
                        ),
                        onPressed: () async {
                          if (_review.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Ulasan tidak boleh kosong!"),
                            ));
                          }
                          else if (_formKey.currentState!.validate()){
                          final response = await request.postJson(
                            "http://127.0.0.1:8000/forum_discussion/create_forum_flutter/",
                            jsonEncode(<String, dynamic>{
                              'username': request.jsonData['username'],
                              'password': request.jsonData['password'],
                              'bookTitle': _bookTitle,
                              'rating': _rating,
                              'review': _review,
                              'date': DateTime.now().toString(),
                              'addedBy': request.jsonData['username'],
                            }),
                          );
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Diskusi baru berhasil disimpan!"),
                          ));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Terdapat kesalahan, silakan coba lagi."),
                          ));
                        }
                      }
                    },
                    child: const Text(
                      "Tambahkan",
                      style: TextStyle(color: Colors.white),
                    ),
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