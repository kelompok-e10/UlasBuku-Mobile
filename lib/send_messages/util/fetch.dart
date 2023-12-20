import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:ulasbuku_mobile/send_messages/model/messages_model.dart';

Future<Map<String, dynamic>> fetchUserInfo(String username) async {
  var url = Uri.parse(
      'https://ulasbuku-e10-tk.pbp.cs.ui.ac.id/send_messages/user_info/$username/');
  var response = await http.get(
    url,
    // headers: {
    //   "Access-Control-Allow-Origin": "*",
    //   "Content-Type": "application/json",
    // },
  );
  Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
  return data;
}

Future<List<Messages>> fetchMessages(
    String currentUser, String selectedUser) async {
  var url = Uri.parse(
      'https://ulasbuku-e10-tk.pbp.cs.ui.ac.id/send_messages/message_list/$currentUser/$selectedUser/');
  var response = await http.get(
    url,
    // headers: {
    //   "Access-Control-Allow-Origin": "*",
    //   "Content-Type": "application/json",
    // },
  );
  List<Messages> messagesList =
      (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((json) => Messages.fromJson(json))
          .toList();
  return messagesList;
}
