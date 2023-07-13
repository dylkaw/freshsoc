import 'package:flutter/material.dart';
import 'package:freshsoc/services/auth.dart';

class ConfirmLogout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Logout'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Are you sure you want to log out?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            AuthService().signOut();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
