import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String uid;
  final String name;
  final String course;
  final Timestamp dateTime;
  final String title;
  final String category;
  final String bodyText;
  final int likes;

  PostModel({
    required this.uid,
    required this.name,
    required this.course,
    required this.dateTime,
    required this.title,
    required this.category,
    required this.bodyText,
    required this.likes,
  });

  factory PostModel.fromSnapshot(Map<String, dynamic> document) {
    return PostModel(
        uid: document["uid"],
        name: document["name"],
        course: document["course"],
        dateTime: document["dateTime"],
        title: document["title"],
        category: document["category"],
        bodyText: document["bodyText"],
        likes: document["likes"]);
  }
}
