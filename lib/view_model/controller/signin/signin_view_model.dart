import 'package:celient_project/model/login/login_model.dart';
import 'package:celient_project/repository/login_repository/login_repository.dart';
import 'package:celient_project/res/routes/routes_name.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view_model/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInViewModel extends GetxController {
  final _api = LoginRepository();

  UserPreference userPreference = UserPreference();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final nameFocusNode = FocusNode().obs;
  final emailForgetPasController = TextEditingController().obs;
  final emailForgetPasFocusNode = FocusNode().obs;

  RxBool loading = false.obs;
  String? getCookie;

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

  void loginApi() async {
    try {
      Get.dialog(
        WillPopScope(
          child: const Center(child: CupertinoActivityIndicator()),
          onWillPop: () async {
            return false;
          },
        ),
        barrierDismissible: true,
      );
      loading.value = true;
      Map<String, dynamic> data = {
        'email': emailController.value.text,
        'password': passwordController.value.text,
      };

      _api.loginApi(data).then((value) {
        loading.value = false;
        Get.back();  // Close the dialog when response is received

        if (value['status_code'] == 200) {
          Data userData = Data(
            bearerToken: value['data']['bearer_token'],
            uniqueId: value['data']['unique_id'],
          );

          LoginModel userModel = LoginModel(
            statusCode: value['status_code'],
            message: value['message'],
            error: value['error'],
            data: userData,
            isLogin: true,
          );

          userPreference.saveUser(userModel).then((value) {
            // releasing resources because we are not going to use this
            Get.delete<SignInViewModel>();
            Get.toNamed(RouteName.bottomNavBar)!.then((value) {});
            Utils.snackBar('Login', 'Login successfully');
          }).onError((error, stackTrace) {});
        } else if (value['status_code'] == 400) {
          Utils.snackBar('Login', value['message']);
          Get.offAllNamed(RouteName.signInView);  // Go back to SignInView
        } else {
          Utils.snackBar('Login', 'Unknown error occurred');
          Get.offAllNamed(RouteName.signInView);  // Go back to SignInView
        }
      }).onError((error, stackTrace) {
        loading.value = false;
        Get.back();  // Close the dialog in case of error
        Utils.snackBar('Error', error.toString());
        Get.offAllNamed(RouteName.signInView);  // Go back to SignInView in case of error
      });
    } catch (e) {
      Utils.snackBar('Login Failed', 'An error occurred while logging in');

      Get.dialog(
        WillPopScope(
          child: const Center(child: CupertinoActivityIndicator()),
          onWillPop: () async {
            return false;
          },
        ),
        barrierDismissible: false,
      );

      await Future.delayed(const Duration(seconds: 2)); // Delay for 2 seconds

      Get.back(); // Close the dialog
      Get.offAllNamed(RouteName.signInView); // Navigate back to the login screen
      return; // End the function
    }
  }


}
