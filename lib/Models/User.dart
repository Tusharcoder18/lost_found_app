import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String username;
  Gender gender;
  String profilePicture;

  User({
    this.uid,
    this.username,
    this.gender,
    this.profilePicture,
  });

  Map<String, dynamic> toMap(bool forFirebase) {
    Map<String, dynamic> userMap = {
      'username': this.username,
      'gender': gender.toString(),
      'profilePicture': profilePicture,
    };
    if (!forFirebase) {
      userMap['key'] = this.uid;
    } else {
      userMap['lastEditedDate'] = FieldValue.serverTimestamp();
    }
    return userMap;
  }

  factory User.fromJson(Map<String, dynamic> json, String uid) {
    Gender gender = Gender.values
        .firstWhere((gender) => gender.toString() == json['gender']);

    return User(
      username: json['username'],
      profilePicture: json['profilePicture'],
      gender: gender,
      uid: uid,
    );
  }
}

enum Gender { male, female, others }
