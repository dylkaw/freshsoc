import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:freshsoc/services/database.dart";

class LikeButton extends StatefulWidget {
  final String postId;
  final List<String> likes;

  const LikeButton({
    super.key,
    required this.postId,
    required this.likes,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  final currentUser = FirebaseAuth.instance.currentUser;
  bool? isLiked = false;

  @override
  Widget build(BuildContext context) {
    final db = DatabaseService(user: currentUser);
    return SizedBox(
        height: 13,
        child: TextButton(
            onPressed: () async {
              bool likeStatus = await db.getLikeStatus(widget.postId);
              setState(() {
                isLiked = !likeStatus;
              });
              DocumentReference postRef = FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.postId);

              if (isLiked!) {
                postRef.update({
                  'likes': FieldValue.arrayUnion([currentUser!.uid])
                });
              } else {
                postRef.update({
                  'likes': FieldValue.arrayRemove([currentUser!.uid])
                });
              }
            },
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
            ),
            child: Row(
              children: [
                FutureBuilder(
                    future: db.getNumLikes(widget.postId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Text(
                            "${snapshot.data} Likes",
                            style: const TextStyle(color: Color(0xFF8A8A8A)),
                          );
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else {
                          return const Text("Something went wrong");
                        }
                      } else {
                        return Text(
                          "${widget.likes.length} Likes",
                          style: const TextStyle(color: Color(0xFF8A8A8A)),
                        );
                      }
                    }),
                const SizedBox(
                  width: 5,
                ),
                FutureBuilder(
                    future: db.getLikeStatus(widget.postId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Icon(
                            snapshot.data!
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            size: 12.0,
                            color:
                                snapshot.data! ? Colors.red : Color(0xFF8A8A8A),
                          );
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else {
                          return const Text("Something went wrong");
                        }
                      } else {
                        return Icon(
                          Icons.favorite_outline,
                          size: 12.0,
                          color: Color(0xFF8A8A8A),
                        );
                      }
                    }),
              ],
            )));
  }
}
