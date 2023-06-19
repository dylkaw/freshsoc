import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freshsoc/models/post_model.dart';
import 'package:freshsoc/models/reply_model.dart';
import 'package:freshsoc/models/user_model.dart';

class DatabaseService {
  final User? user;

  DatabaseService({required this.user});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection("posts");

  Future updateUserData(String name, String email, String course) async {
    return await userCollection.doc(user!.uid).set({
      'name': name,
      'email': email,
      'course': course,
    });
  }

  Future<UserModel> getUserDetails() async {
    final snapshot = await userCollection.doc(user!.uid).get();
    // print(snapshot.data().runtimeType);
    final userData = UserModel.fromSnapshot(
        snapshot.data() as Map<String, dynamic>, user!.emailVerified);
    return userData;
  }

  Future createPost(String title, String category, String bodyText) async {
    final userData = await getUserDetails();
    return await postCollection.doc().set({
      'uid': user!.uid,
      'name': userData.name,
      'course': userData.course,
      'dateTime': DateTime.now(),
      'title': title,
      'category': category,
      'bodyText': bodyText,
      'likes': 0
    });
  }

  Future<List<PostModel>> getPosts({required String category}) async {
    if (category == "All categories") {
      final snapshot =
          await postCollection.orderBy('dateTime', descending: true).get();
      final postData = snapshot.docs.map((e) {
        String postId = e.reference.id;
        return PostModel.fromSnapshot(e.data() as Map<String, dynamic>, postId);
      }).toList();
      return postData;
    } else {
      final snapshot = await postCollection
          .where("category", isEqualTo: category)
          .orderBy('dateTime', descending: true)
          .get();
      final postData = snapshot.docs.map((e) {
        String postId = e.reference.id;
        return PostModel.fromSnapshot(e.data() as Map<String, dynamic>, postId);
      }).toList();
      return postData;
    }
  }

  Future addReply(String postId, String reply) async {
    final userData = await getUserDetails();
    postCollection.doc(postId).collection("replies").doc().set({
      'uid': user!.uid,
      'name': userData.name,
      'course': userData.course,
      'dateTime': DateTime.now(),
      'reply': reply,
    });
  }

  Future<List<ReplyModel>> getReplies(String postId) async {
    final snapshot = await postCollection
        .doc(postId)
        .collection("replies")
        .orderBy('dateTime', descending: true)
        .get();
    final replyData = snapshot.docs
        .map((e) => ReplyModel.fromSnapshot(e.data() as Map<String, dynamic>))
        .toList();
    return replyData;
  }

  Future<int> getNumReplies(String postId) async {
    AggregateQuerySnapshot query =
        await postCollection.doc(postId).collection('replies').count().get();
    final numReplies = query.count;
    return numReplies;
  }
}
