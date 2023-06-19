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
        : Scaffold(
            appBar: AppBar(
              title: Text('Academic Progress - ${_userModel!.course}'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Home Course: ${_userModel!.course}'), // Non-editable field
                  SizedBox(height: 10),
                  // Add other fields and widgets here
                ],
              ),
            ),
          );
  }
}
