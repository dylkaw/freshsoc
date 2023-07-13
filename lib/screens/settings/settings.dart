import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:freshsoc/screens/home/components/profile_card.dart";
import "package:freshsoc/services/auth.dart";
import "package:freshsoc/services/database.dart";
import "package:freshsoc/shared/constants.dart";
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AuthService().signOut(); // Call your sign out method here
          },
          child: Text('Log Out'),
        ),
      ),
    );
  }
}
