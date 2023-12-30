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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Picture
            Container(
              color: Colors
                  .blue, // Set the desired background color for the picture section
              child: Image.asset(
                'assets/images/nus_soc.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      'Login to FreshSoC',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                            label: const Text('Password'),
                          ),
                          validator: (val) => val!.length < 6
                              ? 'Password contains >6 characters'
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
                            backgroundColor: nusOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);
                              UserModel? result = await _auth
                                  .signInWithEmailAndPassword(email, password);
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
                        SizedBox(
                          height: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            widget.switchAuthScreen('register');
                          },
                          child: const Text(
                            'Create new account',
                            style: TextStyle(color: nusBlue),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.switchAuthScreen('forgot_password');
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: nusBlue),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
