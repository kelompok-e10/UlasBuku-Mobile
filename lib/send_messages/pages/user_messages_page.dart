// ignore_for_file: must_be_immutable, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ulasbuku_mobile/send_messages/pages/users_page.dart';
import 'package:ulasbuku_mobile/send_messages/util/fetch.dart';
import 'dart:convert' as convert;
import '../../screens/login.dart';
import '../model/messages_model.dart';

class ChatPage extends StatefulWidget {
  int usernameId, selectedUserId;
  String selectedUsername;
  ChatPage({
    super.key,
    required this.usernameId,
    required this.selectedUserId,
    required this.selectedUsername,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  Map<String, String> userLoggedIn = LoggedIn.userData;

  @override
  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(24),
                  bottomRight: sendByMe
                      ? const Radius.circular(0)
                      : const Radius.circular(24),
                  topRight: const Radius.circular(24),
                  bottomLeft: sendByMe
                      ? const Radius.circular(24)
                      : const Radius.circular(0)),
              color: sendByMe
                  ? const Color.fromARGB(255, 234, 236, 240)
                  : const Color.fromARGB(255, 211, 228, 243)),
          child: Text(
            message,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w500),
          ),
        )),
      ],
    );
  }

  Widget chatMessage() {
    return FutureBuilder<List<Messages>>(
      future: fetchMessages(
          LoggedIn.userData['username']!, widget.selectedUsername),
      builder: (context, AsyncSnapshot<List<Messages>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Belum ada percakapan.'),
          );
        } else {
          List<Messages> messagesList = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 90.0, top: 130),
            itemCount: messagesList.length,
            reverse: true,
            itemBuilder: (context, index) {
              Messages message = snapshot.data![index];
              return chatMessageTile(message.fields.text,
                  widget.usernameId == snapshot.data![index].fields.sender);
            },
          );
        }
      },
    );
  }

  addMessage(request) async {
    if (messageController.text != "") {
      String text = messageController.text;
      messageController.text = "";
      var data = convert.jsonEncode(
        <String, String?>{
          'recipient': widget.selectedUserId.toString(),
          'text': text,
        },
      );
      final response = await request.postJson(
          "https://ulasbuku-e10-tk.pbp.cs.ui.ac.id/send_messages/send/", data);
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Pesan berhasil dikirim!"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Terjadi kesalahan, mohon coba lagi."),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        padding: const EdgeInsets.only(top: 60.0),
        child: Stack(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 50.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.12,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: chatMessage()),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: const Icon(
                      Icons.account_circle,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    widget.selectedUsername,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              alignment: Alignment.bottomCenter,
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message",
                        hintStyle: const TextStyle(color: Colors.black45),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              addMessage(request);
                              setState(() {});
                            },
                            child: const Icon(Icons.send_rounded))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
