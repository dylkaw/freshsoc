import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshsoc/models/user_model.dart';
import 'package:freshsoc/services/database.dart';
import 'package:freshsoc/shared/widgets/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileCard extends StatefulWidget {
  final User? user;
  const ProfileCard({required this.user, Key? key}) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
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
        padding: EdgeInsets.all(20),
        child: Container(
          color: Color.fromRGBO(0, 61, 124, 0.66),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: updateProfilePicture,
                  child: CircleAvatar(
                    backgroundImage: _userModel!.profilePictureUrl == null
                        ? AssetImage('assets/images/soccat.png')
                            as ImageProvider<Object>
                        : NetworkImage(_userModel!.profilePictureUrl!)
                            as ImageProvider<Object>,
                    radius: 70,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  _userModel!.name,
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  _userModel!.course,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  _userModel!.email,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      );
  }

  Future<void> updateProfilePicture() async {
    final pickedFile =
        await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxHeight: 512,
          maxWidth: 200,
          imageQuality: 100,
          );
    if (pickedFile == null) {
      return null;
    }

    // Reference to the location you want to upload to in Firebase Storage
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_pics/${widget.user!.uid}');

    await storageReference.putFile(File(pickedFile.path));
    String imageUrl = await storageReference.getDownloadURL();

    // Save the new profile picture URL to Firestore
    await db!.updateUserProfilePicture(widget.user!.uid, imageUrl);

    // Update the state to reflect the new profile picture
    _loadUserData();
  }
}
