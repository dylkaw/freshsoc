import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freshsoc/models/post_model.dart';
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
    return await postCollection.doc().set({
      'uid': user!.uid,
      'dateTime': DateTime.now(),
      'title': title,
      'category': category,
      'bodyText': bodyText,
      'likes': 0
    });
  }

  Future<List<PostModel>> allPosts() async {
    final snapshot = await postCollection.get();
    final postData = snapshot.docs
        .map((e) => PostModel.fromSnapshot(e.data() as Map<String, dynamic>))
        .toList();
    return postData;
  }
}
