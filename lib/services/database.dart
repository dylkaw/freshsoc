import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freshsoc/models/user_model.dart';

class DatabaseService {
  final User? user;

  DatabaseService({required this.user});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

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
    final testData = UserModel.fromSnapshot(
        snapshot.data() as Map<String, dynamic>, user!.emailVerified);
    final userData = UserModel(
        name: "helo", course: "coursade", email: "email", emailVerified: true);
    return testData;
  }
}
