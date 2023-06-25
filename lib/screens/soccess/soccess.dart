import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshsoc/screens/home/components/identity_card.dart';
import 'package:freshsoc/screens/soccess/components/acad_progress.dart';
import 'package:freshsoc/screens/soccess/components/bza.dart';
import 'package:freshsoc/screens/soccess/components/com_eng.dart';
import 'package:freshsoc/screens/soccess/components/com_sci.dart';
import 'package:freshsoc/screens/soccess/components/info_sec.dart';
import 'package:freshsoc/screens/soccess/components/info_sys.dart';
import 'package:freshsoc/services/database.dart';
import 'package:freshsoc/shared/constants.dart';
import 'package:freshsoc/models/user_model.dart';

class Soccess extends StatefulWidget {
  Soccess({Key? key});

  @override
  _SoccessState createState() => _SoccessState();
}

class _SoccessState extends State<Soccess> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _databaseService =
      DatabaseService(user: FirebaseAuth.instance.currentUser);

  UserModel? _userModel;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDetails = await _databaseService.getUserDetails();
      setState(() {
        _userModel = userDetails;
      });
    }
  }

  Widget _buildCourseWidget() {
    if (_userModel != null) {
      switch (_userModel!.course) {
        case 'Business Analytics':
          return BusinessAnalytics();
        case 'Computer Engineering':
          return ComputerEngineering();
        case 'Computer Science':
          return ComputerScience();
        case 'Information Security':
          return InformationSecurity();
        case 'Information Systems':
          return InformationSystems();
        default:
          return SizedBox.shrink();
      }
    } else {
      return SizedBox.shrink();
    }
  }

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
            _buildCourseWidget(),
          ],
        ),
      ),
    );
  }
}
