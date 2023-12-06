// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    Model model;
    int pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String isbn;
    String bookTitle;
    String bookAuthor;
    int yearOfPublication;
    String publisher;
    String imageUrlS;

    Fields({
        required this.isbn,
        required this.bookTitle,
        required this.bookAuthor,
        required this.yearOfPublication,
        required this.publisher,
        required this.imageUrlS,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        isbn: json["isbn"],
        bookTitle: json["book_title"],
        bookAuthor: json["book_author"],
        yearOfPublication: json["year_of_publication"],
        publisher: json["publisher"],
        imageUrlS: json["image_url_s"],
    );

    Map<String, dynamic> toJson() => {
        "isbn": isbn,
        "book_title": bookTitle,
        "book_author": bookAuthor,
        "year_of_publication": yearOfPublication,
        "publisher": publisher,
        "image_url_s": imageUrlS,
    };
}

enum Model {
    BOOK_BOOK
}

final modelValues = EnumValues({
    "book.book": Model.BOOK_BOOK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
