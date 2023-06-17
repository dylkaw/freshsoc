import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshsoc/models/user_model.dart';
import 'package:freshsoc/screens/authenticate/authenticate.dart';
import 'package:freshsoc/screens/home/home.dart';
import 'package:freshsoc/screens/navigator.dart';
import 'package:freshsoc/screens/socialize/post_view.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // return either home or authenticate widget
    final user = Provider.of<User?>(context);

    if (user == null || !user.emailVerified) {
      return Authenticate();
    } else {
      // return NavigationController(selectedIndex: 0);
      return ViewPost();
    }
  }
}
