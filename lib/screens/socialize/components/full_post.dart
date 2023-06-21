import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshsoc/screens/socialize/components/like_button.dart';
import 'package:freshsoc/services/database.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class FullPost extends StatefulWidget {
  final String postId;
  final String name;
  final String course;
  final DateTime dateTime;
  final String title;
  final String category;
  String bodyText;
  final List<String> likes;

  FullPost(
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
  State<FullPost> createState() => _FullPostState();
}

class _FullPostState extends State<FullPost> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final db = DatabaseService(user: _auth.currentUser);

    return Container(
        padding: const EdgeInsets.all(8.0),
        width: size.width * 0.95,
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: const BoxDecoration(
          color: Color(0xFF94AEC8),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
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
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            const SizedBox(height: 5.0),
            ReadMoreText(
              widget.bodyText,
              trimLines: 8,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'more',
              trimExpandedText: 'less',
              moreStyle: const TextStyle(
                  color: Color(0xFF8A8A8A), fontWeight: FontWeight.bold),
              lessStyle: const TextStyle(
                  color: Color(0xFF8A8A8A), fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LikeButton(postId: widget.postId, likes: widget.likes),
                SizedBox(
                    height: 12.0,
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
                                      return const Text("Something went wrong");
                                    }
                                  } else {
                                    return const SizedBox(height: 13);
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
                SizedBox(
                    height: 12.0,
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
                              style: TextStyle(
                                  fontSize: 12.0, color: Color(0xFF8A8A8A)),
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
        ));
  }
}
