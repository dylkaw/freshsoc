import 'package:flutter/material.dart';
import 'package:freshsoc/models/custom_user.dart';
import 'package:freshsoc/services/auth.dart';
import 'package:freshsoc/shared/constants.dart';

class Verification extends StatefulWidget {
  final Function switchAuthScreen;
  const Verification({required this.switchAuthScreen, super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 230, 229),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 61, 124),
          elevation: 0.0,
          title: const Text('Sign in to FreshSoC'),
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    'A verification email has been sent to your email address. Please verify your email before logging in.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 61, 124),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                    onPressed: () {
                      widget.switchAuthScreen('signIn');
                    },
                    child: const Text(
                      'Return to sign in page',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ])));
  }
}
