import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshsoc/screens/settings/change_password.dart';
import 'package:freshsoc/screens/settings/confirm_logout.dart';
import 'package:freshsoc/screens/settings/update_profile.dart';
import 'package:freshsoc/screens/settings/confirm_logout.dart';
import 'package:freshsoc/shared/constants.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _notificationsEnabled = false;

  void updateProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProfile(user: _auth.currentUser),
      ),
    );
  }

  void changePassword(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChangePassword()));
  }

  Future<void> _logOut(BuildContext context) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return ConfirmLogout();
      },
    );
  }

  void toggleNotification(bool value) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Notifications'),
        content:
            Text('Notifications have been toggled ${value ? 'on' : 'off'}.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          )
        ],
      ),
    );
    setState(() {
      _notificationsEnabled = value;
    });
  }

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
          ListTile(
            title: Text(
              'Notifications',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            title: Text(
              'Toggle Notifications',
              style: TextStyle(fontSize: 24),
            ),
            value: _notificationsEnabled,
            onChanged: toggleNotification,
            secondary: Icon(Icons.notifications),
          ),
          ListTile(
            title: Text(
              'Account',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Update Profile',
              style: TextStyle(fontSize: 24),
            ),
            onTap: () {
              updateProfile(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text(
              'Change Password',
              style: TextStyle(fontSize: 24),
            ),
            onTap: () {
              changePassword(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Log Out',
              style: TextStyle(fontSize: 24),
            ),
            onTap: () {
              _logOut(context);
            },
          ),
        ],
      ),
    );
  }
}
