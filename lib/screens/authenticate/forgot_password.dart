import 'package:flutter/material.dart';
import 'package:freshsoc/models/user_model.dart';
import 'package:freshsoc/services/auth.dart';
import 'package:freshsoc/shared/constants.dart';
import 'package:freshsoc/shared/widgets/loading.dart';

class ForgotPassword extends StatefulWidget {
  final Function switchAuthScreen;
  const ForgotPassword({super.key, required this.switchAuthScreen});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // text field state
  String email = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          flexibleSpace: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: nusBlue,
          elevation: 0.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              const Text(
                'Reset Your Password',
                style: TextStyle(
                  fontSize: 25.0,
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
                    Builder(
                      builder: (context) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: nusOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                              error = '';
                            });

                            bool isRegistered =
                                await _auth.isEmailRegistered(email);
                            if (isRegistered) {
                              bool success =
                                  await _auth.sendPasswordResetEmail(email);
                              if (success) {
                                setState(() {
                                  error =
                                      'Password reset email sent. Please check your inbox.';
                                });
                              } else {
                                setState(() {
                                  error =
                                      'Failed to send password reset email. Please try again.';
                                });
                              }
                            } else {
                              setState(() {
                                error =
                                    'Email is not registered. Please enter a valid email.';
                              });
                            }

                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.switchAuthScreen('signIn');
                },
                child: const Text('Return back to Login',
                    style: TextStyle(color: nusBlue)),
              ),
              const SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
