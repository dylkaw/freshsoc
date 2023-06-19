import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:freshsoc/screens/socialize/view_post.dart';
import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  final String postId;
  final String name;
  final String course;
  final DateTime dateTime;
  final String title;
  final String category;
  String bodyText;
  int likes;

  PostCard(
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
          onPressed: () {
            Navigator.pushNamed(context, ViewPost.routeName, arguments: {
              'postId': widget.postId,
              'name': widget.name,
              'course': widget.course,
              'category': widget.category,
              'dateTime': widget.dateTime,
              'title': widget.title,
              'bodyText': widget.bodyText,
              'likes': widget.likes
            });
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
                              Text(
                                "${widget.likes} likes",
                                style:
                                    const TextStyle(color: Color(0xFF8A8A8A)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.favorite_outline,
                                size: 12.0,
                                color: Color(0xFF8A8A8A),
                              )
                            ],
                          ))),
                  SizedBox(
                      height: 13,
                      child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                          ),
                          child: Row(
                            children: const [
                              Text(
                                "0 Replies",
                                style: TextStyle(color: Color(0xFF8A8A8A)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.comment_outlined,
                                size: 12.0,
                                color: Color(0xFF8A8A8A),
                              )
                            ],
                          ))),
                  SizedBox(
                      height: 13,
                      child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                          ),
                          child: Row(
                            children: const [
                              Text(
                                "Flag",
                                style: TextStyle(color: Color(0xFF8A8A8A)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.flag_outlined,
                                size: 12.0,
                                color: Color(0xFF8A8A8A),
                              )
                            ],
                          )))
                ],
              ),
            ],
          ),
        ));
  }
}
