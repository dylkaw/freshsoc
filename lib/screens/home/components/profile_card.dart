import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freshsoc/models/user_model.dart';
import 'package:freshsoc/services/auth.dart';
import 'package:freshsoc/services/database.dart';
import 'package:freshsoc/shared/widgets/loading.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatefulWidget {
  final User? user;
  const ProfileCard({required this.user, super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  DatabaseService? userData;

  @override
  Widget build(BuildContext context) {
    final db = DatabaseService(user: widget.user);
    return FutureBuilder(
      future: db.getUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            UserModel userData = snapshot.data as UserModel;
            return Text(
                "${userData.name} ${userData.email} ${userData.course}");
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Text("Something went wrong");
          }
        } else {
          return Loading();
        }
      },
    );
  }
}
