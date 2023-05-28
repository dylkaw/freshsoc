import 'package:flutter/material.dart';
import 'package:freshsoc/screens/authenticate/sign_in.dart';
import 'package:freshsoc/screens/authenticate/register.dart';
import 'package:freshsoc/screens/authenticate/verification.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  String authScreen = 'signIn';

  void switchAuthScreen(String screen) {
    setState(() => authScreen = screen);
  }

  @override
  Widget build(BuildContext context) {
    if (authScreen == 'signIn') {
      return SignIn(switchAuthScreen: switchAuthScreen);
    } else if (authScreen == 'register') {
      return Register(switchAuthScreen: switchAuthScreen);
    } else {
      return Verification(switchAuthScreen: switchAuthScreen);
    }
  }
}
