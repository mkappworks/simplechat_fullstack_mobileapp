import 'package:flutter/material.dart';

import 'package:flutter_frontend/utilities/constants.dart';

class ProfileModalBottomSheetText extends StatelessWidget {
  final String value;

  ProfileModalBottomSheetText({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: Theme.of(context)
          .textTheme
          .subtitle1
          ?.copyWith(color: kColorLightBlue),
    );
  }
}
