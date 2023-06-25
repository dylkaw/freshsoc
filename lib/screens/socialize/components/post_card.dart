import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshsoc/screens/socialize/components/flag_button.dart';
import 'package:freshsoc/screens/socialize/components/like_button.dart';
import 'package:freshsoc/screens/socialize/view_post.dart';
import 'package:freshsoc/services/database.dart';
import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  final String postId;
  final String name;
  final String course;
  final DateTime dateTime;
  final String title;
  final String category;
  final String bodyText;
  final List<String> likes;

  const PostCard(
      {super.key,
      required this.postId,
      required this.name,
      required this.course,
      required this.dateTime,
      required this.title,
      required this.category,
      required this.bodyText,
      required this.likes});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final db = DatabaseService(user: currentUser);

    return Container(
        padding: const EdgeInsets.all(8.0),
        width: size.width * 0.95,
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: const BoxDecoration(
          color: Color(0xFF94AEC8),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
              minimumSize: MaterialStateProperty.all<Size>(Size.zero),
              foregroundColor: MaterialStateProperty.all(Colors.black),
              splashFactory: NoSplash.splashFactory),
          onPressed: () async {
            await Navigator.pushNamed(context, ViewPost.routeName, arguments: {
              'postId': widget.postId,
              'name': widget.name,
              'course': widget.course,
              'category': widget.category,
              'dateTime': widget.dateTime,
              'title': widget.title,
              'bodyText': widget.bodyText,
              'likes': widget.likes
            });
            setState(() {});
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${widget.name} - ${widget.course}"),
                  Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(widget.category),
                  )
                ],
              ),
              Text(
                DateFormat('dd/MM/yyyy HH:mm').format(widget.dateTime),
                style: const TextStyle(color: Color(0xFF8A8A8A)),
              ),
              const SizedBox(height: 5.0),
              Text(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              const SizedBox(height: 5.0),
              Text(
                widget.bodyText,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LikeButton(
                    postId: widget.postId,
                    likes: widget.likes,
                  ),
                  SizedBox(
                      height: 13,
                      child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                          ),
                          child: Row(
                            children: [
                              FutureBuilder(
                                  future: db.getNumReplies(widget.postId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          "${snapshot.data} Replies",
                                          style: const TextStyle(
                                              color: Color(0xFF8A8A8A)),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(snapshot.error.toString());
                                      } else {
                                        return const Text(
                                            "Something went wrong");
                                      }
                                    } else {
                                      return const Text(
                                        "0 Replies",
                                        style:
                                            TextStyle(color: Color(0xFF8A8A8A)),
                                      );
                                    }
                                  }),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.comment_outlined,
                                size: 12.0,
                                color: Color(0xFF8A8A8A),
                              )
                            ],
                          ))),
                  FlagButton(
                    postId: widget.postId,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
