import 'package:flutter/material.dart';
import 'package:freshsoc/models/user_model.dart';
import 'package:freshsoc/services/auth.dart';
import 'package:freshsoc/shared/constants.dart';
import 'package:freshsoc/shared/widgets/loading.dart';

class Register extends StatefulWidget {
  final Function switchAuthScreen;
  const Register({super.key, required this.switchAuthScreen});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // text field state
  String name = '';
  String course = 'Computer Science';
  String email = '';
  String password = '';
  String confirmPassword = '';
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
                    'Register freshSoC Account',
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
        body: loading
            ? const Loading()
            : SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 35.0),
                    child: Form(
                        key: _formKey,
                        child: Column(children: [
                          const SizedBox(height: 15.0),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                label: const Text('Full Name'),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please enter your name';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(() => name = val);
                              }),
                          const SizedBox(height: 15.0),
                          DropdownButtonFormField(
                              value: "Computer Science",
                              decoration: textInputDecoration.copyWith(
                                label: const Text("Course of Study"),
                              ),
                              items: const [
                                DropdownMenuItem(
                                    value: "Business Analytics",
                                    child: Text("Business Analytics")),
                                DropdownMenuItem(
                                    value: "Computer Engineering",
                                    child: Text("Computer Engineering")),
                                DropdownMenuItem(
                                    value: "Computer Science",
                                    child: Text("Computer Science")),
                                DropdownMenuItem(
                                    value: "Information Security",
                                    child: Text("Information Security")),
                                DropdownMenuItem(
                                    value: "Information Systems",
                                    child: Text("Information Systems")),
                              ],
                              onChanged: (val) {
                                setState(() => course = val as String);
                              }),
                          const SizedBox(height: 15.0),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                label: const Text('Email'),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please enter an email';
                                } else if (!val.endsWith('@u.nus.edu') &&
                                    !val.endsWith('@comp.nus.edu.sg')) {
                                  return 'Email domain should be @u.nus.edu or @comp.nus.edu.sg';
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
                                  ? 'Password must contain >6 characters'
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
                              validator: (val) => val == password
                                  ? null
                                  : 'Passwords do not match!',
                              onChanged: (val) {
                                setState(() => confirmPassword = val);
                              }),
                          const SizedBox(height: 15.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: nusOrange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        name, course, email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Please supply a valid email';
                                    loading = false;
                                  });
                                } else {
                                  widget.switchAuthScreen('verification');
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
                              widget.switchAuthScreen('signIn');
                            },
                            child: const Text('Return back to Login',
                                style: TextStyle(color: nusBlue)),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          )
                        ]))),
              ));
  }
}
