import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freshsoc/models/user_model.dart';
import 'package:freshsoc/services/auth.dart';
import 'package:freshsoc/services/database.dart';
import 'package:freshsoc/shared/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

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
                      GestureDetector(
                        onTap: updateProfilePicture,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(userData.profilePictureUrl),
                          radius: 70,
                        ),
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

  Future<String?> updateProfilePicture() async {
    // Let the user pick an image
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      // The user cancelled the operation
      return null;
    }

    // Create a reference to the location you want to upload to in Firebase Storage
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_pics/${widget.user!.uid}');

    // Upload the file to Firebase Storage
    UploadTask uploadTask = storageReference.putFile(File(pickedFile.path));

    // Snapshot of the uploading task
    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    // Return the URL of the uploaded image
    return downloadUrl;
  }
}
