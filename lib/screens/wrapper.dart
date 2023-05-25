import 'package:flutter/material.dart';
import 'package:freshsoc/models/custom_user.dart';
import 'package:freshsoc/screens/authenticate/authenticate.dart';
import 'package:freshsoc/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // return either home or authenticate widget
    final user = Provider.of<CustomUser?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
