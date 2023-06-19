import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshsoc/screens/socialize/components/full_post.dart';
import 'package:freshsoc/services/auth.dart';
import 'package:freshsoc/services/database.dart';
import 'package:freshsoc/shared/constants.dart';

class ViewPost extends StatefulWidget {
  const ViewPost({super.key});
  static const routeName = '/socialize/viewpost';

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final replyText = TextEditingController();

  Map data = {};
  String reply = '';

  @override
  Widget build(BuildContext context) {
    final db = DatabaseService(user: _auth.currentUser);
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 230, 229),
      appBar: AppBar(
        backgroundColor: nusOrange,
        elevation: 0.0,
        title: const Text('View Post'),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: Column(
        children: <Widget>[
          FullPost(
              name: data['name'],
              course: data['course'],
              dateTime: data['dateTime'],
              title: data['title'],
              category: data["category"],
              bodyText: data["bodyText"],
              likes: data["likes"]),
          Expanded(child: Container()),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                const SizedBox(
                  width: 10,
                ),
                // First child is enter comment text input
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      autocorrect: false,
                      validator: (value) =>
                          reply.isEmpty ? "Reply cannot be empty!" : null,
                      controller: replyText,
                      minLines: 1,
                      maxLines: 10,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(15, 0, 5, 10),
                        suffix: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              db.addReply(data['postId'], reply);
                              replyText.clear();
                              setState(() => reply = '');
                            }
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.zero),
                              minimumSize:
                                  MaterialStateProperty.all<Size>(Size.zero),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              splashFactory: NoSplash.splashFactory),
                          child: const Text(
                            "Done",
                            style: TextStyle(height: 1.0),
                          ),
                        ),
                        hintText: "Add a reply...",
                        labelStyle: const TextStyle(
                            fontSize: 20.0, color: Colors.white),
                        fillColor: Colors.blue,
                        isCollapsed: true,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          borderSide: BorderSide(
                            width: 0.5,
                          ),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() => reply = val);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ])),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}
