import "package:flutter/material.dart";
import "package:freshsoc/services/auth.dart";

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

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
    );
  }
}
