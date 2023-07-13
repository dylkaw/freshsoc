import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:freshsoc/screens/home/components/profile_card.dart";
import "package:freshsoc/services/auth.dart";
import "package:freshsoc/services/database.dart";
import "package:freshsoc/shared/constants.dart";
import 'package:provider/provider.dart';

class UpdateProfile extends StatelessWidget {
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
                  'Update Profile',
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
        child: Text(
          'Update Profile',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
      ),
    );
  }
}
