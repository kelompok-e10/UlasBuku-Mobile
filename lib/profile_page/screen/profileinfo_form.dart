import 'package:flutter/material.dart';
import 'package:ulasbuku_mobile/screens/login.dart';
import 'package:ulasbuku_mobile/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileInfoFormPage extends StatefulWidget {
  const ProfileInfoFormPage({Key? key}) : super(key: key);

  @override
  State<ProfileInfoFormPage> createState() => _ProfileInfoFormPageState();
}

class _ProfileInfoFormPageState extends State<ProfileInfoFormPage> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String contact = '';
  String description = '';

  Future<bool> updateProfileOnServer(Map<String, dynamic> data) async {
    String username = LoggedIn.userData['username']!;
    String url =
        'https://ulasbuku-e10-tk.pbp.cs.ui.ac.id/user_profile/$username/update_profile_flutter/';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(135, 148, 192, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(1, 1, 1, 0.8),
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
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'First Name'),
              onChanged: (value) {
                setState(() {
                  firstName = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Last Name'),
              onChanged: (value) {
                setState(() {
                  lastName = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Contact'),
              onChanged: (value) {
                setState(() {
                  contact = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  Map<String, dynamic> data = {
                    'first_name': firstName,
                    'last_name': lastName,
                    'contact': contact,
                    'description': description,
                  };

                  bool success = await updateProfileOnServer(data);

                  if (success) {
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Failed to update profile. Please try again.'),
                      ),
                    );
                  }
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
