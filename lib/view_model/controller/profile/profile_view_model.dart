import 'dart:convert';
import 'dart:io';
import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/model/user/user_model.dart';
import 'package:celient_project/repository/user_profile_repository/user_profile_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../utils/utils.dart';

class ProfileViewModel extends GetxController {
  final emailController = TextEditingController().obs;
  final phoneNumberController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final licenceNumberController = TextEditingController().obs;
  final licenceExpNumberController = TextEditingController().obs;
  final cityController = TextEditingController().obs;
  final stateController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final faceMaskController = TextEditingController().obs;
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

  RefreshController refreshProfileController = RefreshController();


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

   refreshApi() {
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
        'licence_no': licenceNumberController.value.text,
        'licence_exp': licenceExpNumberController.value.text,
        'state': stateController.value.text,
        'city': cityController.value.text,
        'address': addressController.value.text,
        'zip': zipController.value.text,
        'facemask': faceMaskController.value.text,
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
      // Prepare a data map to store base64 strings
      Map<String, dynamic> data = {};

      // Check if avatar is not null and exists, then process it
      if (avatar != null && File(avatar).existsSync()) {
        print('Processing Avatar Image at Path: $avatar');

        final avatarFile = File(avatar);
        final avatarExtension = avatar.split(".").last;
        final avatarBytes = await avatarFile.readAsBytes();
        final avatarBase64 = 'data:image/$avatarExtension;base64,${base64Encode(avatarBytes)}';

        data['avatar'] = avatarBase64;
      }

      // Check if licence is not null and exists, then process it
      if (licence != null && File(licence).existsSync()) {
        print('Processing License Image at Path: $licence');

        final licenceFile = File(licence);
        final licenceExtension = licence.split(".").last;
        final licenceBytes = await licenceFile.readAsBytes();
        final licenceBase64 = 'data:image/$licenceExtension;base64,${base64Encode(licenceBytes)}';

        data['license'] = licenceBase64;
      }

      // Check if both avatar and license are not uploaded
      if (data.isEmpty) {
        //Utils.snackBar('No File Uploaded', 'Please upload at least one image file.');
        print('Neither avatar nor license image is uploaded');
        return;
      }

      final response = await _api.updateImageUser(data);

      if (response['status_code'] == 200) {
        Utils.snackBar('Image Uploaded', 'Successfully');
      } else {
        Utils.snackBar('Failed to Upload Image', 'Server responded with status code: ${response['status_code']}');
        print('The error is Uploading image  $response');
      }

    } catch (e) {
      Utils.snackBar('Failed to Update Image', 'An error occurred while updating image: ${e.toString()}');
      print('The error is Uploading image  ${e.toString()}');
      return; // End the function
    }
  }

}
