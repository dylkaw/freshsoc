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
      'profilePictureUrl':
          'https://4.bp.blogspot.com/-pce7rOe1VpM/VfBa0G6H0EI/AAAAAAAABUM/ttEOVpQSQy8/s1600/1-welfare-bg.png',
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
      'likes': [],
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

  Future<int> getNumLikes(String postId) async {
    final snapshot = await postCollection.doc(postId).get();
    return List<String>.from(snapshot["likes"] ?? []).length;
  }

  Future<bool> getLikeStatus(String postId) async {
    final snapshot = await postCollection.doc(postId).get();
    final likeList = List<String>.from(snapshot["likes"] ?? []);
    return likeList.contains(user!.uid);
  }

  Future flagPost(String postId, String reason) async {
    final userData = await getUserDetails();
    postCollection.doc(postId).collection("flags").doc().set({
      'uid': user!.uid,
      'name': userData.name,
      'course': userData.course,
      'reason': reason,
    });
  }

  Future<void> updateUserProfilePicture(
      String uid, String newProfilePicUrl) async {
    return userCollection
        .doc(uid)
        .update({'profilePictureUrl': newProfilePicUrl});
  }

  Future<void> updateUserNUSNETID(String uid, String nusnetId) async {
    return userCollection.doc(uid).update({'nusnetId': nusnetId});
  }

  Future<void> updateUserMatriculationNumber(
      String uid, String matriculationNumber) async {
    return userCollection
        .doc(uid)
        .update({'matriculationNumber': matriculationNumber});
  }

  Future<void> updateName(String uid, String newName) async {
    return userCollection.doc(uid).update({'name': newName});
  }
}
