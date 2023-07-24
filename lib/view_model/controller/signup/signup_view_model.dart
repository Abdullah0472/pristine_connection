import 'dart:convert';
import 'dart:io';

import 'package:celient_project/repository/signup_repository/signup_repository.dart';
import 'package:celient_project/res/routes/routes_name.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view_model/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
//import 'package:multiple_images_picker/multiple_images_picker.dart';


class SignUpViewModel extends GetxController {
  final _api = SignUpRepository();

  var currentStep = 0.obs;
  UserPreference userPreference = UserPreference();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final vehicleTypeController = TextEditingController().obs;
  final weightController = TextEditingController().obs;
  final lengthController = TextEditingController().obs;
  final vehicleRegistrationController = TextEditingController().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final nameFocusNode = FocusNode().obs;
  final phoneFocusNode = FocusNode().obs;

  RxList<Asset> images = RxList<Asset>();

  List files = [];



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

  // void signUpApi() async {
  //   try {
  //     Get.dialog(
  //       WillPopScope(
  //           child: const Center(child: CupertinoActivityIndicator()),
  //           onWillPop: () async {
  //             return false;
  //           }),
  //       barrierDismissible: true,
  //     );
  //
  //     for (int i = 0; i < images.length; i++) {
  //       var path2 = await FlutterAbsolutePath.getAbsolutePath(
  //           images[i].identifier);
  //       var file = await getImageFromFileAsset(path2);
  //       var base64Image = base64Encode(file.readAsBytesSync());
  //       files.add(base64Image);
  //     }
  //     loading.value = true;
  //     Map data = {
  //       'email': emailController.value.text,
  //       'password': passwordController.value.text,
  //       'name': nameController.value.text,
  //       'phone': phoneController.value.text,
  //       'files': files,
  //     };
  //     _api.signUpApi(data).then((value) {
  //       loading.value = false;
  //
  //       if (value['error'] == 'user not found') {
  //         Utils.snackBar('SignUp', value['error']);
  //       } else {
  //         Utils.snackBar('SignUp', 'SignUp Successfully');
  //       }
  //     }).onError((error, stackTrace) {
  //       loading.value = false;
  //       Utils.snackBar('Error', error.toString());
  //     });
  //   } catch (e) {
  //     Utils.snackBar('Signup Failed', 'An error occurred while signing up');
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


  void signUpApi() async {
    try {
      Get.dialog(
        WillPopScope(
            child: const Center(child: CupertinoActivityIndicator()),
            onWillPop: () async {
              return false;
            }),
        barrierDismissible: true,
      );

      for (int i = 0; i < images.length; i++) {
        var byteData = await images[i].getByteData();
        var base64Image = base64Encode(byteData.buffer.asUint8List());
        files.add(base64Image);
      }
      loading.value = true;
      Map data = {
        'email': emailController.value.text,
        'password': passwordController.value.text,
        'name': nameController.value.text,
        'phone': phoneController.value.text,
        'files': files,
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
    } catch (e) {
      Utils.snackBar('Signup Failed', 'An error occurred while signing up');
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

  Future<void> loadAssets() async {
    try {
      List<Asset> resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      );
      images.value = resultList;
    } catch (e) {
      print(e.toString());
    }
  }


  getImageFromFileAsset(String path) async {
    final file = File(path);
    return file;
  }
}
