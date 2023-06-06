import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String course;
  final String email;
  final bool emailVerified;

  UserModel({
    required this.name,
    required this.course,
    required this.email,
    required this.emailVerified,
  });

  factory UserModel.fromSnapshot(
      Map<String, dynamic> document, bool emailVerified) {
    return UserModel(
        name: document["name"],
        course: document["course"],
        email: document["email"],
        emailVerified: emailVerified);
  }
}
