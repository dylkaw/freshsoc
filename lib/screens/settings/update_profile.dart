import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:freshsoc/models/user_model.dart';
import "package:freshsoc/services/database.dart";
import "package:freshsoc/shared/constants.dart";
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateProfile extends StatefulWidget {
  final User? user;
  const UpdateProfile({required this.user, Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  DatabaseService? db;
  String? _profilePictureUrl;
  String? _name;
  bool _isEditingName = false;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    db = DatabaseService(user: widget.user);
    _nameController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await db!.getUserDetails();
    _profilePictureUrl = userData.profilePictureUrl;
    _nameController.text = userData.name;
    setState(() {});
  }

  void _toggleEditingName() {
    setState(() {
      _isEditingName = !_isEditingName;
      if (!_isEditingName) {
        _saveName();
      }
    });
  }

  Future<void> _saveName() async {
    if (_nameController.text.isNotEmpty) {
      final db = DatabaseService(user: widget.user);
      await db.updateName(
        widget.user!.uid,
        _nameController.text,
      );
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: updateProfilePicture,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: _profilePictureUrl == null
                        ? AssetImage('assets/images/soccat.png')
                            as ImageProvider<Object>
                        : NetworkImage(_profilePictureUrl!)
                            as ImageProvider<Object>,
                    radius: 70,
                  ),
                  Icon(
                    Icons.edit,
                    color: Colors.white.withOpacity(0.8),
                    size: 100.0,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FocusScope(
                    node: FocusScopeNode(canRequestFocus: _isEditingName),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      enabled: true, // Always enable the field
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _toggleEditingName,
                  child: Text(_isEditingName ? 'Save' : 'Edit'),
                ),
              ],
            ),
            // Add other fields here
          ],
        ),
      ),
    );
  }

  Future<void> updateProfilePicture() async {
    final pickedFile = await ImagePicker().pickImage(
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
    _profilePictureUrl = imageUrl;
    setState(() {});
  }
}
