import 'dart:convert';
import 'dart:io';

import 'package:celient_project/repository/signup_repository/signup_repository.dart';
import 'package:celient_project/res/routes/routes_name.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view_model/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class SignUpViewModel extends GetxController {
  final _api = SignUpRepository();

  //String? groupValue;
  RxString groupValue = 'No'.obs;

  var currentStep = 0.obs;

  UserPreference userPreference = UserPreference();
 /// -------------- Personal Information -------------- ///
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final licenceNumberController = TextEditingController().obs;
  final licenceExpireController = TextEditingController().obs;
  final faceMaskController = TextEditingController().obs;
  /// -------------- Personal Information -------------- ///

  /// -------------- Vehicle Information -------------- ///
  final vehicleTypeController = TextEditingController().obs;
  final weightController = TextEditingController().obs;
  final lengthController = TextEditingController().obs;
  final vehicleRegistrationController = TextEditingController().obs;
  final vehicleModelController = TextEditingController().obs;
  final vehicleMakeController = TextEditingController().obs;
  final vehicleYearController = TextEditingController().obs;
  final heightController = TextEditingController().obs;
  final widthController = TextEditingController().obs;
  final cargoDimsController = TextEditingController().obs;
  final doorDimsController = TextEditingController().obs;
  final dockHeightController = TextEditingController().obs;
  final palletJeckController = TextEditingController().obs;
  final liftGateController = TextEditingController().obs;
  final tempCountController = TextEditingController().obs;
  /// -------------- Vehicle Information -------------- ///

  /// -------------- Bank Account Information -------------- ///
  final bankNameController = TextEditingController().obs;
  final accountNameController = TextEditingController().obs;
  final routingController = TextEditingController().obs;
  final accountNumberController = TextEditingController().obs;
  /// -------------- Bank Account Information -------------- ///
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final nameFocusNode = FocusNode().obs;
  final phoneFocusNode = FocusNode().obs;
  RxList<File> selectedImages = RxList<File>(); // Reactive list of selected images
  final picker = ImagePicker(); // Instance of Image picker


  RxBool loading = false.obs;
  ////////////////////////Validation for Email///////////////////////////
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter the Detail";
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

  Future<void> getImages() async {
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 100, // To set quality of images
      maxHeight: 1000, // To set maxheight of images that you want in your app
      maxWidth: 1000, // To set maxheight of images that you want in your app
    );
    if (pickedFiles.isNotEmpty) {
      // Convert List<XFile> to List<File>
      List<File> files = pickedFiles.map((xfile) => File(xfile.path)).toList();


      selectedImages.addAll(files);

    } else {
      Get.snackbar(
        'No image selected',
        '',
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    }
  }

  RxString accountDocPic = ''.obs;


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

      loading.value = true;

      // List<String> multiplePicBase64List = []; // List to store base64-encoded images
      // // Convert each image to base64 and add to the list
      // for (File imageFile in selectedImages) {
      //   final extension = imageFile.path.split(".").last;
      //   final imageBytes = await imageFile.readAsBytes();
      //   final imageBase64 = 'data:image/$extension;base64,${base64Encode(imageBytes)}';
      //   multiplePicBase64List.add(imageBase64);
      // }

      String multiplePicBase64String = ''; // String to store base64-encoded images separated by ';'
// Convert each image to base64 and add to the string
      for (File imageFile in selectedImages) {
        final extension = imageFile.path.split(".").last;
        final imageBytes = await imageFile.readAsBytes();
        final imageBase64 = 'data:image/$extension;base64,${base64Encode(imageBytes)}';
        if (multiplePicBase64String.isNotEmpty) {
          // If the string is not empty, add a ';' before adding the new image
          multiplePicBase64String += ';';
        }
        multiplePicBase64String += imageBase64;
      }


      /// Account Document Information Picture ///
      final accountDocPicFile = File(accountDocPic.value);
      if (!accountDocPicFile.existsSync()) {
        print('Unload Place file does not exist at this path: $accountDocPic');
        return; // Exit if the file doesn't exist
      }

      final accountDocPicExtension = accountDocPic.split(".").last;
      final accountDocPicBytes = await accountDocPicFile.readAsBytes();
      final accountDocPicBase64 = 'data:image/$accountDocPicExtension;base64,${base64Encode(accountDocPicBytes)}';


      Map data = {
        'email': emailController.value.text,
        'password': passwordController.value.text,
        'name': nameController.value.text,
        'phone': phoneController.value.text,
        'reg_no': vehicleRegistrationController.value.text,
        'licence_no': licenceNumberController.value.text,
        'licence_exp': licenceExpireController.value.text,
        'facemask': faceMaskController.value.text,
        'type': vehicleTypeController.value.text,
        'model': vehicleModelController.value.text,
        'vehicle_make': vehicleMakeController.value.text,
        'year': vehicleYearController.value.text,
        'height': heightController.value.text,
        'length': lengthController.value.text,
        'width': widthController.value.text,
       // 'weight': weightController.value.text,
        'cargo_dims': cargoDimsController.value.text,
        'door_dims': doorDimsController.value.text,
        'dock_height': dockHeightController.value.text,
        'pallet_jack': palletJeckController.value.text,
        'lift_gate':liftGateController.value.text,
        'temp_count': tempCountController.value.text,
        'vehicle_images': multiplePicBase64String, //multiplePicBase64List,
        'bank_name': bankNameController.value.text,
        'account_name': accountNameController.value.text,
        'routing': routingController.value.text,
        'account_number': accountNumberController.value.text,
        'bank_docs': accountDocPicBase64,
      };
      _api.signUpApi(data).then((value) {
        loading.value = false;

        if (value['error'] == 'user not found') {
          Utils.snackBar('SignUp', value['error']);
          print('The Error Occur in First if: ${value['error']}');
        } else {
          Utils.snackBar('SignUp', 'SignUp Successfully');
          print('The Data is Upload Successfully');
        }
      }).onError((error, stackTrace) {
        loading.value = false;
        Utils.snackBar('Error', error.toString());
        print('The Error Occur in onError: ${error.toString()}');
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

