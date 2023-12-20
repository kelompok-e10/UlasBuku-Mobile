// To parse this JSON data, do
//
//     final messages = messagesFromJson(jsonString);

import 'dart:convert';

List<Messages> messagesFromJson(String str) =>
    List<Messages>.from(json.decode(str).map((x) => Messages.fromJson(x)));

String messagesToJson(List<Messages> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Messages {
  String model;
  int pk;
  Fields fields;

  Messages({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int sender;
  int recipient;
  String text;
  DateTime timestamp;
  bool isRead;

  Fields({
    required this.sender,
    required this.recipient,
    required this.text,
    required this.timestamp,
    required this.isRead,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        sender: json["sender"],
        recipient: json["recipient"],
        text: json["text"],
        timestamp: DateTime.parse(json["timestamp"]),
        isRead: json["is_read"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "recipient": recipient,
        "text": text,
        "timestamp": timestamp.toIso8601String(),
        "is_read": isRead,
      };
}
