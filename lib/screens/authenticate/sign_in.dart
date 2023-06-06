import 'package:flutter/material.dart';
import 'package:freshsoc/models/user_model.dart';
import 'package:freshsoc/services/auth.dart';
import 'package:freshsoc/shared/constants.dart';
import 'package:freshsoc/shared/widgets/loading.dart';

class SignIn extends StatefulWidget {
  final Function switchAuthScreen;
  const SignIn({required this.switchAuthScreen, super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: loading
            ? const Loading()
            : Column(
                children: [
                  //Picture
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/nus_soc.jpg',
                      )
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 35.0),
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
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 61, 124),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => loading = true);
                                  UserModel? result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      error = 'Invalid credentials';
                                      loading = false;
                                    });
                                  } else if (!result.emailVerified) {
                                    setState(() {
                                      error = 'Please verify your email!';
                                      loading = false;
                                    });
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
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            )
                          ]
                          ),
                          ),
                          ),
                ],
              ));
  }
}
