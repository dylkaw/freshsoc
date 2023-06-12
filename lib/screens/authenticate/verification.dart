import 'package:flutter/material.dart';
import 'package:freshsoc/models/user_model.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: nusBlue,
          elevation: 0.0,
          title: const Text('Register FreshSoC Account'),
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    'We have sent a verification link to your NUS email.',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Verify your account by clicking the link sent to your email.',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: nusOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                    onPressed: () {
                      widget.switchAuthScreen('signIn');
                    },
                    child: const Text(
                      'Return to Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ])));
  }
}
