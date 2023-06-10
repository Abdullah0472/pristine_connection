import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignInViewModel extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  final emailForgetPasController = TextEditingController().obs;
  final emailForgetPasFocusNode = FocusNode().obs;

  String? getCookie;

  ////////////////////////Validation for Email///////////////////////////
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Your Email";
    }
    // if (!GetUtils.isEmail(value)) {
    //   return "Enter Valid Email";
    // }
    return null;
  }

  ////////////////////////Validation for Password///////////////////////////
  String? validatePassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[]).{}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else if (value != passwordController.value.text) {
        "Not Match";
        return null;
      } else {
        return null;
      }
    }
  }

}
