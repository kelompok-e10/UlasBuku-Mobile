import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ulasbuku_mobile/profile_page/model/profile.dart';
import 'package:ulasbuku_mobile/screens/login.dart';
import 'package:ulasbuku_mobile/widgets/left_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:ulasbuku_mobile/profile_page/screen/profileinfo_form.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(135, 148, 192, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 1, 1, 0.8),
         title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/UlasBuku.png', // Replace with your image path
                width: 40,
                height: 40,
              ),
            ),
            const Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    LoggedIn.user_data['username']!,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileInfoFormPage(),
                            ),
                          ).then((value) {
                            // This code will be executed when the _ProfileInfoFormPage is popped
                            // You can fetch and update the profile data here if needed
                          });
                        },
                        heroTag: 'profile',
                        elevation: 0,
                        backgroundColor: Colors.white,
                        label: const Text("Edit Profile Info"),
                        icon: const Icon(Icons.description),
                      ),
                    ],
                  ),
                  const _ProfileInfo()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo({Key? key}) : super(key: key);

  Future<Profile> fetchProfile() async {
    String username = LoggedIn.user_data['username']!;
    var url = Uri.parse('http://127.0.0.1:8000/user_profile/$username/get_json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // Decode response directly into a Map
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // Assuming the response contains a single profile, not a list
    return Profile.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchProfile(),
      builder: (context, AsyncSnapshot<Profile> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null || snapshot.data?.profileData == null) {
          return const Center(
            child: Text(
              ' ',
              style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
            ),
          );
        } else {
          // Data has been loaded successfully
          Profile profile = snapshot.data!;
          
          return Card(
            elevation: 4,
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${profile.description}',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'First Name: ${profile.profileData.firstName} ',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Last Name: ${profile.profileData.lastName} ',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Contact: ${profile.profileData.contact}',
                    style: TextStyle(fontSize: 18),
                  ),
                  // Add more fields as needed
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


