// To parse this JSON data, do
//
//     final forum = forumFromJson(jsonString);

import 'dart:convert';
import 'package:ulasbuku_mobile/models/book.dart';

List<Forum> forumFromJson(String str) => List<Forum>.from(json.decode(str).map((x) => Forum.fromJson(x)));

String forumToJson(List<Forum> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Forum {
    Book bookInfo;
    String review;
    int rating;
    DateTime dateAdded;
    String user;

    Forum({
        required this.bookInfo,
        required this.review,
        required this.rating,
        required this.dateAdded,
        required this.user,
    });

    factory Forum.fromJson(Map<String, dynamic> json) => Forum(
        bookInfo: Book.fromJson(json["book_info"]),
        review: json["review"],
        rating: json["rating"],
        dateAdded: DateTime.parse(json["date_added"]),
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "book_info": bookInfo.toJson(),
        "review": review,
        "rating": rating,
        "date_added": "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
        "user": user,
    };
}