import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshsoc/screens/home/components/profile_card.dart';
import 'package:freshsoc/services/auth.dart';
import 'package:freshsoc/services/database.dart';
import 'package:freshsoc/shared/constants.dart';
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
  String _errorMessage = '';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  labelStyle: TextStyle(fontSize: 20),
                  hintText: 'Enter current password',
                ),
                style: TextStyle(fontSize: 18),
                obscureText: true,
                onChanged: (value) {
                  setState(() => _oldPassword = value.trim());
                },
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(fontSize: 20),
                  hintText: 'Enter new password',
                ),
                style: TextStyle(fontSize: 18),
                obscureText: true,
                onChanged: (value) {
                  setState(() => _newPassword = value.trim());
                },
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  labelStyle: TextStyle(fontSize: 20),
                  hintText: 'Re-enter new password',
                ),
                style: TextStyle(fontSize: 18),
                obscureText: true,
                onChanged: (value) {
                  setState(() => _confirmPassword = value.trim());
                },
              ),
              SizedBox(height: 20.0),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: nusBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      _errorMessage = '';
                      if (_oldPassword.isEmpty ||
                          _newPassword.isEmpty ||
                          _confirmPassword.isEmpty) {
                        _errorMessage = 'All fields must be filled';
                      } else if (_newPassword.length < 6) {
                        _errorMessage =
                            'Password must be at least 6 characters long';
                      } else if (_newPassword == _oldPassword) {
                        _errorMessage =
                            'New password should be different from the current password';
                      } else if (_newPassword != _confirmPassword) {
                        _errorMessage = 'Passwords do not match';
                      } else {
                        _changePassword();
                      }
                    });
                  },
                  child: Text(
                    'Change Password',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _changePassword() async {
    User? user = FirebaseAuth.instance.currentUser;
    AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!, password: _oldPassword);

    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(_newPassword);
      setState(() {
        _errorMessage = 'Password successfully changed. Please login again.';
      });

      await Future.delayed(Duration(seconds: 1));

      Navigator.of(context).pop();
      await AuthService().signOut();
    } catch (error) {
      print("Error changing password: " + error.toString());
      setState(() {
        _errorMessage = 'Error changing password';
      });
    }
  }
}
