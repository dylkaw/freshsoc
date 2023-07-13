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
  UserModel? _userModel;

  late TextEditingController _nameController;
  late TextEditingController _courseController;
  late TextEditingController _nusnetIdController;
  late TextEditingController _matriculationNumberController;

  @override
  void initState() {
    super.initState();
    db = DatabaseService(user: widget.user);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _userModel = await db!.getUserDetails();
    _nameController = TextEditingController(text: _userModel!.name);
    _courseController = TextEditingController(text: _userModel!.course);
    _nusnetIdController =
        TextEditingController(text: _userModel!.nusnetId ?? '');
    _matriculationNumberController =
        TextEditingController(text: _userModel!.matriculationNumber ?? '');
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _courseController.dispose();
    _nusnetIdController.dispose();
    _matriculationNumberController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (_nameController.text.isNotEmpty) {
      await db!.updateName(
        widget.user!.uid,
        _nameController.text,
      );
    }
    if (_courseController.text.isNotEmpty) {
      await db!.updateUserCourse(
        widget.user!.uid,
        _courseController.text,
      );
    }
    if (_nusnetIdController.text.isNotEmpty) {
      await db!.updateUserNUSNETID(
        widget.user!.uid,
        _nusnetIdController.text,
      );
    }
    if (_matriculationNumberController.text.isNotEmpty) {
      await db!.updateUserMatriculationNumber(
        widget.user!.uid,
        _matriculationNumberController.text,
      );
    }
    Navigator.of(context).pop();
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
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (_userModel == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // Loading indicator
        ),
      );
    }
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: updateProfilePicture,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: _userModel!.profilePictureUrl == null
                            ? AssetImage('assets/images/soccat.png')
                                as ImageProvider<Object>
                            : NetworkImage(_userModel!.profilePictureUrl!)
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
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _courseController,
                decoration: InputDecoration(
                  labelText: 'Course',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nusnetIdController,
                decoration: InputDecoration(
                  labelText: 'NUSNET ID',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _matriculationNumberController,
                decoration: InputDecoration(
                  labelText: 'Matriculation Number',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: nusBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
