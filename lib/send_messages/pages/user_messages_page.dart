
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
  ChatPage(
      {
        required this.usernameId ,
        required this.selectedUserId,
        required this.selectedUsername,
      });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = new TextEditingController();
  Map<String, String> userLoggedIn = LoggedIn.user_data;

  @override
  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
      sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      bottomRight:
                      sendByMe ? Radius.circular(0) : Radius.circular(24),
                      topRight: Radius.circular(24),
                      bottomLeft:
                      sendByMe ? Radius.circular(24) : Radius.circular(0)),
                  color: sendByMe
                      ? Color.fromARGB(255, 234, 236, 240)
                      : Color.fromARGB(255, 211, 228, 243)),
              child: Text(
                message,
                style: TextStyle(
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
      future: fetchMessages(LoggedIn.user_data['username']!, widget.selectedUsername),
      builder: (context, AsyncSnapshot<List<Messages>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('Belum ada percakapan.'),
          );
        } else {
          List<Messages> messagesList = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.only(bottom: 90.0, top: 130),
            itemCount: messagesList.length,
            reverse: true,
            itemBuilder: (context, index) {
              Messages message = snapshot.data![index];
              return chatMessageTile(message.fields.text, widget.usernameId == snapshot.data![index].fields.sender);
            },
          );
        }
      },
    );
  }

  addMessage(request) async {
    if (messageController.text != ""){
      String text = messageController.text;
      messageController.text = "";
      var data = convert.jsonEncode(
        <String, String?>{
          'recipient': widget.selectedUserId.toString(),
          'text': text,
        },
      );
      final response = await request.postJson(
          "http://127.0.0.1:8000/send_messages/send/", data
      );
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Pesan berhasil dikirim!"),
            )
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Terjadi kesalahan, mohon coba lagi."),
            )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: Color(0xFF553370),
      body: Container(
        padding: EdgeInsets.only(top: 60.0),
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(top: 50.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.12,
                decoration: BoxDecoration(
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Color(0Xffc199cd),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    widget.selectedUsername,
                    style: TextStyle(
                        color: Color(0Xffc199cd),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              margin:
              EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              alignment: Alignment.bottomCenter,
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30),
                child: Container(

                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message",
                        hintStyle: TextStyle(color: Colors.black45),
                        suffixIcon: GestureDetector(
                            onTap: (){
                              addMessage(request);
                              setState(() {});
                            },
                            child: Icon(Icons.send_rounded))),
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