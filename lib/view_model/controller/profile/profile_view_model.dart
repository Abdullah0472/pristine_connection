import 'dart:convert';
import 'dart:io';
import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/model/user/user_model.dart';
import 'package:celient_project/repository/user_profile_repository/user_profile_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';

class ProfileViewModel extends GetxController {
  final emailController = TextEditingController().obs;
  final phoneNumberController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final regNumberController = TextEditingController().obs;
  final cityController = TextEditingController().obs;
  final stateController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final zipController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final phoneNumberFocusNode = FocusNode().obs;
  final regNumberFocusNode = FocusNode().obs;
  final nameFocusNode = FocusNode().obs;
  final cityFocusNode = FocusNode().obs;
  final stateFocusNode = FocusNode().obs;
  final addressNode = FocusNode().obs;
  final zipFocusNode = FocusNode().obs;

  final _api = UserProfileRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final userList = UserModel().obs;
  RxString error = ''.obs;

  RxString avatarPath = ''.obs;
  RxString licencePath = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setUserList(UserModel _value) => userList.value = _value;
  void setError(String _value) => error.value = _value;

  void userListApi() {
    //  setRxRequestStatus(Status.LOADING);

    _api.userListApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.userListApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void updateUserApi() async {
    try {
      Map<String, dynamic> data = {
        'email': emailController.value.text,
        'name': nameController.value.text,
        'phone': phoneNumberController.value.text,
        'reg_no': regNumberController.value.text,
        'state': stateController.value.text,
        'city': cityController.value.text,
        'address': addressController.value.text,
        'zip': zipController.value.text,
      };

      _api.updateUser(data).then((value) {
        Utils.snackBar('Data Uploaded', 'Successfully');
      }).onError((error, stackTrace) {
        Utils.snackBar('Error', error.toString());

        print("The error while sending data ${error.toString()}");
      });
    } catch (e) {
      Utils.snackBar('Failed to Update', 'An error occurred while updating');

      return; // End the function
    }
  }

  void updateImageApi(String avatar, String licence) async {
    try {

      print('Avatar Image Path Before error : $avatar');
      print('License Image Path Before Error : $licence');

      final avatarFile = File(avatar);
      final licenceFile = File(licence);


      if (!avatarFile.existsSync() || !licenceFile.existsSync()) {
        Utils.snackBar('File not found', 'Please select a valid image file.');
        return;
      }

      print('Avatar Image Path: $avatar');
      print('License Image Path: $licence');

      // Extract image extensions
      final avatarExtension = avatar.split(".").last;
      final licenceExtension = licence.split(".").last;

      // Convert the avatar image to base64
      final avatarBytes = await avatarFile.readAsBytes();
      final avatarBase64 = 'data:image/$avatarExtension;base64,${base64Encode(avatarBytes)}';

      // Convert the license image to base64
      final licenceBytes = await licenceFile.readAsBytes();
      final licenceBase64 = 'data:image/$licenceExtension;base64,${base64Encode(licenceBytes)}';

      Map<String, dynamic> data = {
        'license': licenceBase64,
        'avatar': avatarBase64,
      };


      final response = await _api.updateImageUser(data);

      if (response['statusCode'] == 200) {
        Utils.snackBar('Image Uploaded', 'Successfully');
      } else {
        Utils.snackBar('Failed to Upload Image', 'Server responded with status code: ${response['statusCode']}');
        print('The error is Uploading image  $response');
      }


    } catch (e) {
      Utils.snackBar('Failed to Update Image', 'An error occurred while updating image: ${e.toString()}');
      print('The error is Uploading image  ${e.toString()}');
      return; // End the function
    }
  }

}
