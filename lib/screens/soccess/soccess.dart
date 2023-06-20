import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshsoc/screens/home/components/identity_card.dart';
import 'package:freshsoc/screens/soccess/components/acad_progress.dart';
import 'package:freshsoc/screens/soccess/components/com_sci.dart';
import 'package:freshsoc/services/database.dart';
import 'package:freshsoc/shared/constants.dart';

class Soccess extends StatefulWidget {
  Soccess({Key? key});

  @override
  _SoccessState createState() => _SoccessState();
}

class _SoccessState extends State<Soccess> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                  'SoCcess',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: AcadProgress(user: _auth.currentUser),
            ),
            SizedBox(height: 10),
            ComputerScience(),
          ],
        ),
      ),
    );
  }
}
