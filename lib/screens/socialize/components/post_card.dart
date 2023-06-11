import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PostCard extends StatefulWidget {
  final String postId;
  final String uid;
  final DateTime dateTime;
  final String title;
  final String category;
  String bodyText;
  int likes;

  PostCard(
      {super.key,
      required this.postId,
      required this.uid,
      required this.dateTime,
      required this.title,
      required this.category,
      required this.bodyText,
      required this.likes});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
