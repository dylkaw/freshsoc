import "dart:convert";
import "dart:io";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:freshsoc/models/user_model.dart";
import "package:freshsoc/screens/socchat/components/chat_message.dart";
import "package:freshsoc/services/database.dart";
import "package:freshsoc/shared/constants.dart";
import "package:http/http.dart";
import "package:freshsoc/secrets.dart";

class Socchat extends StatefulWidget {
  const Socchat({super.key});

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

  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    db = DatabaseService(user: _auth.currentUser);
    _loadUserData();
    setState(() {
      messages.insert(
          0,
          ChatMessage(
              message:
                  "Hello I'm SoCCat! I’m happy to help you with any questions you may have about SoC.",
              sender: 'Soccat',
              userModel: _userModel));
    });
  }

  Future<void> _loadUserData() async {
    _userModel = await db!.getUserDetails();
    setState(() {});
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
                    'SoCChat',
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
                                });
                                final response = await post(
                                    Uri.parse(
                                        "https://api.openai.com/v1/chat/completions"),
                                    headers: {
                                      'Authorization': 'Bearer $API_KEY',
                                      "Content-Type": "application/json"
                                    },
                                    body: jsonEncode({
                                      "model": "gpt-3.5-turbo",
                                      "messages": [
                                        {
                                          "role": "system",
                                          "content":
                                              "Your answer should be related to National University Singapore School of Computing"
                                        },
                                        {"role": "user", "content": question}
                                      ]
                                    }));
                                final jsonResponse = jsonDecode(response.body);
                                if (jsonResponse['error'] != null) {
                                  throw HttpException(
                                      jsonResponse['error']['message']);
                                }

                                if (jsonResponse["choices"].length > 0) {
                                  setState(() {
                                    messages.insert(
                                        0,
                                        ChatMessage(
                                            message: jsonResponse["choices"][0]
                                                ["message"]["content"],
                                            sender: 'Soccat',
                                            userModel: _userModel));
                                    question = '';
                                  });
                                }
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
