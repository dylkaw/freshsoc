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
            return Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                color: Color.fromRGBO(0, 61, 124, 0.66),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://4.bp.blogspot.com/-pce7rOe1VpM/VfBa0G6H0EI/AAAAAAAABUM/ttEOVpQSQy8/s1600/1-welfare-bg.png'),
                        // To implement user's avatar
                        radius: 70,
                      ),
                      SizedBox(height: 10),
                      Text(
                        userData.name,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        userData.course,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      Text(
                        userData.email,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            );
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
