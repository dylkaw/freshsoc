import 'package:flutter/material.dart';
import 'package:freshsoc/models/custom_user.dart';
import 'package:freshsoc/services/auth.dart';
import 'package:freshsoc/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  // text field state
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 230, 229),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 61, 124),
          elevation: 0.0,
          title: const Text('Register to FreshSoC'),
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 35.0),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBox(height: 15.0),
                  TextFormField(
                      decoration: textInputDecoration.copyWith(
                        label: const Text('Email'),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter an email';
                        } else if (!val.endsWith('@u.nus.edu')) {
                          return 'Email should be in the format XXX@u.nus.edu';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() => email = val);
                      }),
                  const SizedBox(height: 15.0),
                  TextFormField(
                      decoration: textInputDecoration.copyWith(
                        label: const Text('Password'),
                      ),
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      }),
                  const SizedBox(height: 15.0),
                  TextFormField(
                      decoration: textInputDecoration.copyWith(
                        label: const Text('Confirm password'),
                      ),
                      obscureText: true,
                      validator: (val) =>
                          val == password ? null : 'Password does not match!',
                      onChanged: (val) {
                        setState(() => confirmPassword = val);
                      }),
                  const SizedBox(height: 15.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 61, 124),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                    onPressed: () async {
                      print(password);
                      print(confirmPassword);
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() => error = 'Please supply a valid email');
                        }
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    child: const Text('Sign in instead'),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ]))));
  }
}
