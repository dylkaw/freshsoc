import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:freshsoc/screens/home/components/profile_card.dart";
import "package:freshsoc/services/auth.dart";
import "package:freshsoc/services/database.dart";
import "package:freshsoc/shared/constants.dart";
import 'package:provider/provider.dart';
import 'package:freshsoc/screens/settings/change_password.dart';
import 'package:freshsoc/screens/settings/update_profile.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateProfile(BuildContext context) {
    // navigate to update profile screen
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UpdateProfile()));
  }

  void changePassword(BuildContext context) {
    // navigate to change password screen
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChangePassword()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 230, 229),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          flexibleSpace: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Settings',
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
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text('Update Profile'),
              onTap: () {
                updateProfile(context);
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Change Password'),
              onTap: () {
                changePassword(context);
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Toggle Notifications'),
              onTap: () {
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Log Out'),
              onTap: () {
                AuthService().signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
