// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ulasbuku_mobile/screens/login.dart';
import 'package:ulasbuku_mobile/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulasbuku_mobile/screens/menu.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileInfoFormPage extends StatefulWidget {
  const ProfileInfoFormPage({Key? key}) : super(key: key);

  @override
  State<ProfileInfoFormPage> createState() => ProfileInfoFormPageState();
}

class ProfileInfoFormPageState extends State<ProfileInfoFormPage> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String contact = '';

  Future<bool> updateProfileOnServer() async {
    String username = LoggedIn.user_data['username']!;
    String url = 'http://127.0.0.1:8000/user_profile/$username/edit_profile/';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          'first_name': firstName,
          'last_name': lastName,
          'contact': contact,
        },
      );

      if (response.statusCode == 200) {
        // Profile update successful
        return true;
      } else {
        // Profile update failed
        print('HTTP Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Exception occurred during the HTTP request
      print('Exception: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: Color.fromRGBO(135, 148, 192, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 1, 1, 0.8),
        title: const Text(
          'Profile Info',
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
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
              onChanged: (value) {
                setState(() {
                  firstName = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
              onChanged: (value) {
                setState(() {
                  lastName = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Contact'),
              onChanged: (value) {
                setState(() {
                  contact = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  bool success = await updateProfileOnServer();

                  if (success) {
                    // Once the data is updated, navigate back to the profile page
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to update profile. Please try again.'),
                      ),
                    );
                  }
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
