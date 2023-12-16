// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors, sort_child_properties_last

import 'package:ulasbuku_mobile/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulasbuku_mobile/screens/register.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1588580000645-4562a6d2c839?auto=format&fit=crop&q=80&w=2070&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12.0),
          ),
          constraints: BoxConstraints(maxWidth: 500.0, maxHeight: 400),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
              ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:Border.all(color: const Color(0xFFFFFFFF)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFFFFFFF)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                ),
              ),
            ),
            ),          
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Belum terdaftar?'),
                TextButton(
                 onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterApp()),
                  );
                },
                  child: const Text(
                  'Registrasi sekarang!', 
                  style: TextStyle(
                    color: Colors.blue, 
                    decoration: TextDecoration.underline, 
                    decorationColor: Colors.blue
                    )
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;

                // Cek kredensial
                // Untuk menyambungkan Android emulator dengan Django pada localhost,
                // gunakan URL http://10.0.2.2/
                final response = await request.login("http://127.0.0.1:8000/auth/login/", {
                  'username': username,
                  'password': password,
                });

                if (request.loggedIn) {
                  String message = response['message'];
                  String uname = response['username'];
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                        SnackBar(content: Text("$message Selamat datang, $uname.")));
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Login Gagal'),
                      content:
                      Text(response['message']),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
               child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white), // Set text color to white
                ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
              ),
          ),
          ],
        ),
      ),
    ),
  ),
);
  }
}