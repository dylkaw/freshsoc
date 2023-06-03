import 'package:firebase_auth/firebase_auth.dart';
import 'package:freshsoc/models/custom_user.dart';
import 'package:freshsoc/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create custom_user obj based on User
  CustomUser? _customUserFromUser(User? user) {
    return user != null
        ? CustomUser(uid: user.uid, emailVerified: user.emailVerified)
        : null;
  }

  // auth change user stream
  Stream<CustomUser?> get user {
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
      await DatabaseService(uid: user.uid).updateUserData(name, email, course);
      await FirebaseAuth.instance.signOut();
      return _customUserFromUser(user);
    } catch (e) {
      return null;
    }
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
