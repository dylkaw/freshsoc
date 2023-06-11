import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:freshsoc/screens/home/components/profile_card.dart";
import "package:freshsoc/screens/socialize/create_post.dart";
import "package:freshsoc/shared/constants.dart";

class Socialize extends StatefulWidget {
  const Socialize({super.key});

  @override
  State<Socialize> createState() => _SocializeState();
}

class _SocializeState extends State<Socialize> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 230, 229),
      appBar: AppBar(
        title: const Text('SoCialize'),
        backgroundColor: nusOrange,
        elevation: 0.0,
      ),
      body: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: nusBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            )),
        onPressed: () async {
          await Navigator.pushNamed(context, CreatePost.routeName);
          setState(() {});
        },
        child: const Text(
          'CREATE POST',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
