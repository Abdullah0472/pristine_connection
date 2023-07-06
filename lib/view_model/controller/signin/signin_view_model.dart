import 'package:celient_project/model/login/user_model.dart';
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
    // if (!GetUtils.isEmail(value)) {
    //   return "Enter Valid Email";
    // }
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

  // void loginApi() async {
  //   try{
  //   Get.dialog(
  //     WillPopScope(
  //         child: const Center(child: CupertinoActivityIndicator()),
  //         onWillPop: () async {
  //           return false;
  //         }),
  //     barrierDismissible: true,
  //   );
  //   loading.value = true;
  //   Map data = {
  //     'email': emailController.value.text,
  //     'password': passwordController.value.text
  //   };
  //   _api.loginApi(data).then((value) {
  //     loading.value = false;
  //
  //     if (value['error'] == 'user not found') {
  //       Utils.snackBar('Login', value['error']);
  //     } else {
  //       UserModel userModel = UserModel(data: value['bearer_token'], isLogin: true);
  //
  //       userPreference.saveUser(userModel).then((value) {
  //         // releasing resouces because we are not going to use this
  //         Get.delete<SignInViewModel>();
  //         Get.toNamed(RouteName.homeView)!.then((value) {});
  //         Utils.snackBar('Login', 'Login successfully');
  //       }).onError((error, stackTrace) {});
  //     }
  //   }).onError((error, stackTrace) {
  //     loading.value = false;
  //     Utils.snackBar('Error', error.toString());
  //   });
  // }
  //   catch (e) {
  //     Utils.snackBar(
  //         'Login Failed', 'An error occurred while logging in');
  //     // Add logic here to display activity indicator and navigate back after 2 seconds
  //     Get.dialog(
  //       WillPopScope(
  //           child: const Center(child: CupertinoActivityIndicator()),
  //           onWillPop: () async {
  //             return false;
  //           }),
  //       barrierDismissible: false,
  //     );
  //
  //     await Future.delayed(const Duration(seconds: 2)); // Delay for 2 seconds
  //
  //     Get.back(); // Close the dialog
  //     Get.offAllNamed(RouteName.signInView); // Navigate back to login screen
  //     return; // End the function
  //   }
  // }

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

        if (value['error'] == 'user not found') {
          Utils.snackBar('Login', value['error']);
        } else {
          Data userData = Data(
            bearerToken: value['bearer_token'],
            uniqueId: value['unique_id'],
          );

          UserModel userModel = UserModel(
            statusCode: value['status_code'],
            message: value['message'],
            error: value['error'],
            data: userData,
            // isLogin: value['isLogin'],
            // Add this line to set the isLogin value
            isLogin: true,
          );

          userPreference.saveUser(userModel).then((value) {
            // releasing resources because we are not going to use this
            Get.delete<SignInViewModel>();
            Get.toNamed(RouteName.bottomNavBar)!.then((value) {});
            Utils.snackBar('Login', 'Login successfully');
          }).onError((error, stackTrace) {});
        }
      }).onError((error, stackTrace) {
        loading.value = false;
        Utils.snackBar('Error', error.toString());
      });
    } catch (e) {
      Utils.snackBar('Login Failed', 'An error occurred while logging in');
      // Add logic here to display an activity indicator and navigate back after 2 seconds
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
