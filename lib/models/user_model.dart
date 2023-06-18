import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String course;
  final String email;
  final bool emailVerified;
  final String profilePictureUrl;

  UserModel(
      {required this.name,
      required this.course,
      required this.email,
      required this.emailVerified,
      required this.profilePictureUrl});

  factory UserModel.fromSnapshot(
      Map<String, dynamic> document, bool emailVerified) {
    return UserModel(
      name: document["name"],
      course: document["course"],
      email: document["email"],
      emailVerified: emailVerified,
      profilePictureUrl: document["profilePictureUrl"] ??
          "https://4.bp.blogspot.com/-pce7rOe1VpM/VfBa0G6H0EI/AAAAAAAABUM/ttEOVpQSQy8/s1600/1-welfare-bg.png",
    );
  }
}
