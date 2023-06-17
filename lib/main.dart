import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshsoc/firebase_options.dart';
import 'package:freshsoc/screens/navigator.dart';
import 'package:freshsoc/screens/socialize/create_post.dart';
import 'package:freshsoc/screens/socialize/view_post.dart';
import 'package:freshsoc/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freshsoc/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:freshsoc/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      initialData: null,
      value: _auth.authStateChanges(),
      child: MaterialApp(
        home: Wrapper(),
        // home: CreatePost(),
        theme: ThemeData(fontFamily: 'Frutiger'),
        routes: {
          '/socialize': (context) => NavigationController(selectedIndex: 1),
          CreatePost.routeName: (context) => const CreatePost(),
          ViewPost.routeName: (context) => const ViewPost()
        },
      ),
    );
  }
}
