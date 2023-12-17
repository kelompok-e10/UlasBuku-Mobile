// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
    String description;
    ProfileData profileData;

    Profile({
        required this.description,
        required this.profileData,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        description: json["description"],
        profileData: ProfileData.fromJson(json["profile_data"]),
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "profile_data": profileData.toJson(),
    };
}

class ProfileData {
    String firstName;
    String lastName;
    String email;
    String contact;

    ProfileData({
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.contact,
    });

    factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        contact: json["contact"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "contact": contact,
    };
}
