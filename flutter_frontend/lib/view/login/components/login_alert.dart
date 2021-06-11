import 'package:flutter/material.dart';

class LoginAlert extends StatelessWidget {
  final String title;
  final String bodyMessage;

  LoginAlert({
    required this.title,
    required this.bodyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(bodyMessage),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
