import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  final _formKey = GlobalKey<FormState>();

  Map data = {};
  String reply = '';

  @override
  Widget build(BuildContext context) {
    // data = data.isNotEmpty
    //     ? data
    //     : ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 230, 229),
      appBar: AppBar(
        backgroundColor: nusOrange,
        elevation: 0.0,
        title: const Text('SoCialize'),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView(
            children: <Widget>[
              const Text("Message1"),
              const Text("Message2"),
              const Text("Message3"),
              const Text("Message4"),
              const Text("Message5"),
            ],
          )),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                const SizedBox(
                  width: 10,
                ),
                // First child is enter comment text input
                Expanded(
                  child: TextFormField(
                    autocorrect: false,
                    minLines: 1,
                    maxLines: 10,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                      suffix: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.zero),
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            splashFactory: NoSplash.splashFactory),
                        child: const Text(
                          "Done",
                          style: TextStyle(height: 1.0),
                        ),
                      ),
                      hintText: "Add a reply...",
                      labelStyle:
                          const TextStyle(fontSize: 20.0, color: Colors.white),
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
