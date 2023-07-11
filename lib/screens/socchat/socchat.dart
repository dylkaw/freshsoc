import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:freshsoc/models/user_model.dart";
import "package:freshsoc/screens/home/components/profile_card.dart";
import "package:freshsoc/screens/socchat/components/chat_message.dart";
import "package:freshsoc/services/auth.dart";
import "package:freshsoc/services/database.dart";
import "package:freshsoc/shared/constants.dart";
import 'package:provider/provider.dart';

class Socchat extends StatefulWidget {
  Socchat({super.key});

  @override
  State<Socchat> createState() => _SocchatState();
}

class _SocchatState extends State<Socchat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final messages = [];
  final questionText = TextEditingController();

  String question = '';

  DatabaseService? db;
  UserModel? _userModel;

  @override
  void initState() {
    super.initState();
    db = DatabaseService(user: _auth.currentUser);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _userModel = await db!.getUserDetails();
    setState(() {});
    print(_userModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 230, 229),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: AppBar(
            flexibleSpace: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'SoCChAT',
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return messages[index];
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        autocorrect: false,
                        validator: (value) => question.isEmpty
                            ? "Question cannot be empty!"
                            : null,
                        controller: questionText,
                        minLines: 1,
                        maxLines: 8,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(15, 0, 5, 10),
                          suffix: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ChatMessage message = ChatMessage(
                                    message: question,
                                    sender: 'user',
                                    userModel: _userModel);
                                questionText.clear();
                                setState(() {
                                  messages.insert(0, message);
                                  question = '';
                                });
                              }
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero),
                                minimumSize:
                                    MaterialStateProperty.all<Size>(Size.zero),
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                splashFactory: NoSplash.splashFactory),
                            child: const Text(
                              "Done",
                              style: TextStyle(height: 1.0),
                            ),
                          ),
                          hintText: "Ask a question...",
                          labelStyle: const TextStyle(
                              fontSize: 20.0, color: Colors.white),
                          fillColor: Colors.blue,
                          isCollapsed: true,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              width: 0.5,
                            ),
                          ),
                        ),
                        onChanged: (val) {
                          question = val;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ])),
            const SizedBox(
              height: 5,
            )
          ],
        ));
  }
}
