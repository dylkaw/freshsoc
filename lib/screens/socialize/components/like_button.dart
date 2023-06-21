import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:freshsoc/services/database.dart";

class LikeButton extends StatefulWidget {
  final String postId;
  final List<String> likes;

  LikeButton({
    super.key,
    required this.postId,
    required this.likes,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLiked = false;

  @override
  initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final db = DatabaseService(user: currentUser);
    return SizedBox(
        height: 13,
        child: TextButton(
            onPressed: () {
              setState(() {
                isLiked = !isLiked;
              });

              DocumentReference postRef = FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.postId);

              if (isLiked) {
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
                Icon(
                  isLiked ? Icons.favorite : Icons.favorite_outline,
                  size: 12.0,
                  color: isLiked ? Colors.red : Color(0xFF8A8A8A),
                )
              ],
            )));
  }
}
