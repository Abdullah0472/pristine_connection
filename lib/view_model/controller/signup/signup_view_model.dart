
import 'package:celient_project/repository/signup_repository/signup_repository.dart';
import 'package:celient_project/res/routes/routes_name.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view_model/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpViewModel extends GetxController {
  final _api = SignUpRepository();

  UserPreference userPreference = UserPreference();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final nameFocusNode = FocusNode().obs;
  final phoneFocusNode = FocusNode().obs;

  RxBool loading = false.obs;
  ////////////////////////Validation for Email///////////////////////////
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Your Email";
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'validPasswordText'.tr;
    } else {

      if (value != passwordController.value.text) {
        'validPasswordText1'.tr;
        return null;
      } else {
        return null;
      }
    }
  }

  void signUpApi() async {
    try{
      Get.dialog(
        WillPopScope(
            child: const Center(child: CupertinoActivityIndicator()),
            onWillPop: () async {
              return false;
            }),
        barrierDismissible: true,
      );
      loading.value = true;
      Map data = {

        'email': emailController.value.text,
        'password': passwordController.value.text,
        'name': nameController.value.text,
        'phone': phoneController.value.text,

      };
      _api.signUpApi(data).then((value) {
        loading.value = false;

        if (value['error'] == 'user not found') {
          Utils.snackBar('SignUp', value['error']);
        } else {
          Utils.snackBar('SignUp', 'SignUp Successfully');
        }
      }).onError((error, stackTrace) {
        loading.value = false;
        Utils.snackBar('Error', error.toString());
      });
    }
    catch (e) {
      Utils.snackBar(
          'Signup Failed', 'An error occurred while signing up');
      // Add logic here to display activity indicator and navigate back after 2 seconds
      Get.dialog(
        WillPopScope(
            child: const Center(child: CupertinoActivityIndicator()),
            onWillPop: () async {
              return false;
            }),
        barrierDismissible: false,
      );

      await Future.delayed(const Duration(seconds: 2)); // Delay for 2 seconds

      Get.back(); // Close the dialog
      Get.offAllNamed(RouteName.signInView); // Navigate back to login screen
      return; // End the function
    }
  }
}
