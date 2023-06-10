import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String uid;
  final String title;
  final String category;
  final String bodyText;
  final int likes;

  PostModel({
    required this.uid,
    required this.title,
    required this.category,
    required this.bodyText,
    required this.likes,
  });

  factory PostModel.fromSnapshot(Map<String, dynamic> document) {
    return PostModel(
        uid: document["uid"],
        title: document["title"],
        category: document["category"],
        bodyText: document["bodyText"],
        likes: document["likes"]);
  }
}