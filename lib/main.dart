import 'package:flutter/material.dart';
import 'package:freshsoc/firebase_options.dart';
import 'package:freshsoc/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freshsoc/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:freshsoc/models/custom_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
