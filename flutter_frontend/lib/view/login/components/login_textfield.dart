import 'package:flutter/material.dart';

import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/sized_box_functions.dart';

class LoginTextField extends StatelessWidget {
  final bool isEmail;
  final String hintText;
  final TextEditingController textEditingController;

  LoginTextField(
      {required this.isEmail,
      required this.hintText,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
            keyboardType: isEmail ? TextInputType.emailAddress : null,
            textAlign: TextAlign.center,
            controller: textEditingController,
            decoration: kTextFieldDecoration.copyWith(hintText: hintText)),
        addVerticalSpace(16),
      ],
    );
  }
}
