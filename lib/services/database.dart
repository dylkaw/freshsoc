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
      'profilePictureUrl':
          'https://4.bp.blogspot.com/-pce7rOe1VpM/VfBa0G6H0EI/AAAAAAAABUM/ttEOVpQSQy8/s1600/1-welfare-bg.png',
    });
  }

  Future<UserModel> getUserDetails() async {
    final snapshot = await userCollection.doc(user!.uid).get();
    // print(snapshot.data().runtimeType);
    final testData = UserModel.fromSnapshot(
        snapshot.data() as Map<String, dynamic>, user!.emailVerified);
    final userData = UserModel(
        name: "helo",
        course: "coursade",
        email: "email",
        emailVerified: true,
        profilePictureUrl:
            'https://4.bp.blogspot.com/-pce7rOe1VpM/VfBa0G6H0EI/AAAAAAAABUM/ttEOVpQSQy8/s1600/1-welfare-bg.png');
    return testData;
  }

  Future<void> updateUserProfilePicture(
      String uid, String newProfilePicUrl) async {
    return userCollection
        .doc(uid)
        .update({'profilePictureUrl': newProfilePicUrl});
  }
}
