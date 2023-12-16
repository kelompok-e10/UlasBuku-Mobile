import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulasbuku_mobile/screens/login.dart';

import '../send_messages/pages/users_page.dart';


class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(LoggedIn.user_data['username']!),
              accountEmail: const Text(""),
              currentAccountPicture: const CircleAvatar(
                  child: Icon(
                    Icons.account_circle,
                  )
              ),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              image: DecorationImage(image: AssetImage('assets/background.png'), fit: BoxFit.cover)
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book) ,
            title: const Text('Daftar Buku'),
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home())
              );
            }
          ),
          ListTile(
            leading: const Icon(Icons.forum),
            title: const Text('Forum'),
            onTap: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home())
              );
            }
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Pesan'),
            onTap: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home())
              );
            }
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async{
              final response = await request.logout(
                  "http://127.0.0.1:8000/auth/logout/");
              String message = response["message"];
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message Terima kasih sudah berkunjung, $uname"),
                ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message"),
                ));
              }
            }
          )
        ]
      )
    );
  }
}