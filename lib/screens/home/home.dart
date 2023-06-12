import 'package:flutter/material.dart';
import 'package:freshsoc/models/user_model.dart';
import 'package:freshsoc/services/auth.dart';
import 'package:freshsoc/services/database.dart';
import 'package:freshsoc/shared/constants.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserModel?>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Homepage',
        ),
        backgroundColor: nusOrange,
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.33,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                color: nusBlue,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile picture
                      CircleAvatar(
                          radius: 50.0,
                          // To implement using user's profile picture in database
                          backgroundImage:
                              AssetImage('assets/images/soccat.png')),
                      const SizedBox(height: 10.0),
                      // User's name
                      Text(
                        user?.name ?? '',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(height: 5.0),
                      // User's course
                      Text(
                        user?.course ?? '',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
