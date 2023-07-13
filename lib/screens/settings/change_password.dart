import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:freshsoc/screens/home/components/profile_card.dart";
import "package:freshsoc/services/auth.dart";
import "package:freshsoc/services/database.dart";
import "package:freshsoc/shared/constants.dart";
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  String _oldPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          flexibleSpace: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Change Password',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: nusOrange,
          elevation: 0.0,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: 'Enter current password'),
                validator: (value) =>
                    value!.isEmpty ? 'Password can\'t be empty' : null,
                obscureText: true,
                onChanged: (value) {
                  setState(() => _oldPassword = value.trim());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: 'Enter new password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password can\'t be empty';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  } //ensures that new password is also at least 6 characters
                  return null;
                },
                obscureText: true,
                onChanged: (value) {
                  setState(() => _newPassword = value.trim());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: 'Confirm new password'),
                validator: (value) =>
                    value != _newPassword ? 'Passwords do not match' : null,
                obscureText: true,
                onChanged: (value) {
                  setState(() => _confirmPassword = value.trim());
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  User? user = FirebaseAuth.instance.currentUser;
                  AuthCredential credential = EmailAuthProvider.credential(
                      email: user!.email!, password: _oldPassword);
                  user.reauthenticateWithCredential(credential).then((_) {
                    user.updatePassword(_newPassword).then((_) async {
                      print("Successfully changed password");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Password changed successfully'),
                      ));
                      await AuthService().signOut();
                    }).catchError((error) {
                      print("Password can't be changed" + error.toString());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Error changing password'),
                      ));
                    });
                  }).catchError((error) {
                    print("Old password is not correct" + error.toString());
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Old password is not correct'),
                    ));
                  });
                }
              },
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
