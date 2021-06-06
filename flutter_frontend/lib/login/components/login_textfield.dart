import 'package:flutter/material.dart';
import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/sized_box_functions.dart';

class LoginTextField extends StatelessWidget {
  final bool isEmail;
  final String hintText;

  late String textFieldValue;

  LoginTextField({
    Key? key,
    required this.isEmail,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
            keyboardType: isEmail ? TextInputType.emailAddress : null,
            textAlign: TextAlign.center,
            onChanged: (value) {
              textFieldValue = value;
            },
            decoration: kTextFieldDecoration.copyWith(hintText: hintText)),
        addVerticalSpace(16),
      ],
    );
  }
}
