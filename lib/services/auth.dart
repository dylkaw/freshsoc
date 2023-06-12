import 'package:firebase_auth/firebase_auth.dart';
import 'package:freshsoc/models/user_model.dart';
import 'package:freshsoc/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create custom_user obj based on User
  Future<UserModel?> _customUserFromUser(User? user) async {
    if (user != null) {
      return DatabaseService(user: user).getUserDetails();
    } else {
      return null;
    }
  }

  // auth change user stream
  Stream<Future<UserModel?>> get user {
    return _auth.authStateChanges().map(_customUserFromUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _customUserFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String name, String course, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await user!.sendEmailVerification();
      await DatabaseService(user: user).updateUserData(name, email, course);
      await FirebaseAuth.instance.signOut();
      return _customUserFromUser(user);
    } catch (e) {
      return null;
    }
  }

  // check if email is a registered account
  Future isEmailRegistered(String email) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: 'temporary_password');
      await result.user!.delete(); // Delete the temporary user
      return true; // Email exists in the database
    } catch (e) {
      return false; // Email does not exist or an error occurred
    }
  }

  // send password reset email
  Future sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // get current user id
  String get currUserId {
    return _auth.currentUser!.uid;
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
