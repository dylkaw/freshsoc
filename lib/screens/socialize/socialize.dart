import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:freshsoc/screens/home/components/profile_card.dart";
import "package:freshsoc/screens/socialize/components/post_card.dart";
import "package:freshsoc/screens/socialize/create_post.dart";
import "package:freshsoc/shared/constants.dart";

class Socialize extends StatefulWidget {
  const Socialize({super.key});

  @override
  State<Socialize> createState() => _SocializeState();
}

class _SocializeState extends State<Socialize> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 230, 229),
      appBar: AppBar(
        title: const Text('SoCialize'),
        backgroundColor: nusOrange,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: nusBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
            onPressed: () async {
              await Navigator.pushNamed(context, CreatePost.routeName);
              setState(() {});
            },
            child: const Text(
              'CREATE POST',
              style: TextStyle(color: Colors.white),
            ),
          ),
          PostCard(
              postId: 'testpostid',
              uid: 'testuid',
              dateTime: DateTime.now(),
              title:
                  'even more evern more evern more hahahahvery very very very long long long testtitle',
              category: 'testcategory',
              bodyText:
                  'very long long body test text very long long body test text very long long body test text very long long body test text very long long body test text very long long body test text very long long body test text very long long body test text very long long body test text very long long body test text very long long body test text ',
              likes: 0),
        ],
      ),
    );
  }
}
