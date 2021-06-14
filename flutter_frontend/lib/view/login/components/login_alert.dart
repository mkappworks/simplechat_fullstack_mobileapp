import 'package:get/get.dart';
import 'package:flutter_frontend/utilities/constants.dart';

class LoginAlert {
  final String title;
  final String bodyMessage;

  LoginAlert({
    required this.title,
    required this.bodyMessage,
  });

  getAlert() {
    Get.snackbar(title, bodyMessage,
        snackPosition: SnackPosition.TOP,
        colorText: kColorBlack,
        backgroundColor: kColorGrey.withOpacity(0.5),
        isDismissible: true);
  }
}
