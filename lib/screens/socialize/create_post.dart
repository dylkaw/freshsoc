import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshsoc/services/auth.dart';
import 'package:freshsoc/services/database.dart';
import 'package:freshsoc/shared/constants.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});
  static const routeName = '/socialize/createpost';

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // text field state
  String title = '';
  String category = 'Discussion';
  String bodyText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 230, 229),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: AppBar(
            flexibleSpace: const SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create Post',
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
          child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 35.0),
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    const SizedBox(height: 15.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                          label: const Text('Title'),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter a title';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          setState(() => title = val);
                        }),
                    const SizedBox(height: 15.0),
                    DropdownButtonFormField(
                        value: "Discussion",
                        decoration: textInputDecoration.copyWith(
                          label: const Text("Category"),
                        ),
                        items: categories
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (val) {
                          setState(() => category = val as String);
                        }),
                    const SizedBox(height: 15.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                          label: const Text('Body Text (optional)'),
                        ),
                        maxLines: 10,
                        onChanged: (val) {
                          setState(() => bodyText = val);
                        }),
                    const SizedBox(height: 15.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: nusBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(user: _firebaseAuth.currentUser)
                              .createPost(title, category, bodyText);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Post Created!',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Text(
                                    "Title: $title",
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Return to SoCialize',
                                          textAlign: TextAlign.center,
                                        ))
                                  ],
                                );
                              });
                        }
                      },
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                  ]))),
        ));
  }
}
