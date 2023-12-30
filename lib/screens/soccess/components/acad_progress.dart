import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshsoc/models/user_model.dart';
import 'package:freshsoc/services/database.dart';
import 'package:freshsoc/shared/widgets/loading.dart';

class AcadProgress extends StatefulWidget {
  final User? user;

  const AcadProgress({required this.user, Key? key}) : super(key: key);

  @override
  State<AcadProgress> createState() => _AcadProgressState();
}

class _AcadProgressState extends State<AcadProgress> {
  DatabaseService? db;
  UserModel? _userModel;

  @override
  void initState() {
    super.initState();
    db = DatabaseService(user: widget.user);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _userModel = await db!.getUserDetails();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _userModel == null
        ? Loading()
        : Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Home Course: ${_userModel!.course}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Secondary Major:',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Minor:',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Special Programs:',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'MCs Completed:',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
