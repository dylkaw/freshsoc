import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:freshsoc/screens/home/components/profile_card.dart";
import "package:freshsoc/services/auth.dart";
import "package:freshsoc/services/database.dart";
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 230, 229),
        appBar: AppBar(
          title: const Text('freshSoC'),
          backgroundColor: Color.fromARGB(255, 0, 34, 186),
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: ProfileCard(user: _auth.currentUser));
  }
}
