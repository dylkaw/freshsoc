import 'package:flutter/material.dart';
import 'package:freshsoc/models/custom_user.dart';
import 'package:freshsoc/services/auth.dart';
import 'package:freshsoc/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function switchAuthScreen;
  const SignIn({required this.switchAuthScreen, super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 230, 229),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 61, 124),
          elevation: 0.0,
          title: const Text('Sign in to FreshSoC'),
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBox(height: 20.0),
                  TextFormField(
                      decoration: textInputDecoration.copyWith(
                        label: const Text('Email'),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter a valid email';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      }),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(
                      label: const Text('Password'),
                    ),
                    validator: (val) => val!.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 61, 124),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        CustomUser? result = await _auth
                            .signInWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() => error = 'Invalid credentials');
                        } else if (!result.emailVerified) {
                          setState(() => error = 'Please verify your email!');
                        }
                      }
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.switchAuthScreen('register');
                    },
                    child: const Text('Create account'),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ]))));
  }
}
