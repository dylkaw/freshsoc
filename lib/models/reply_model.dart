import 'package:cloud_firestore/cloud_firestore.dart';

class ReplyModel {
  final String uid;
  final String name;
  final String course;
  final Timestamp dateTime;
  final String reply;

  ReplyModel({
    required this.uid,
    required this.name,
    required this.course,
    required this.dateTime,
    required this.reply,
  });

  factory ReplyModel.fromSnapshot(Map<String, dynamic> document) {
    return ReplyModel(
        uid: document["uid"],
        name: document["name"],
        course: document["course"],
        dateTime: document["dateTime"],
        reply: document["reply"]);
  }
}
