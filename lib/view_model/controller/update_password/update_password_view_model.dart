import 'package:celient_project/repository/update_password_repository/update_password_repository.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordViewModel extends GetxController {
  final _api = UpdatePasswordRepository();

  final oldPasswordController = TextEditingController().obs;
  final newPasswordController = TextEditingController().obs;

  final oldPasswordFocusNode = FocusNode().obs;

  final newPasswordFocusNode = FocusNode().obs;

  ////////////////////////Validation for Email///////////////////////////
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter The Password";
    }

    return null;
  }

  void updatePasswordApi() async {
    try {
      Map data = {
        'old_password': oldPasswordController.value.text,
        'new_password': newPasswordController.value.text,
      };
      _api.updatePasswordApi(data).then((value) {
        if (value['status_code'] == 200) {
          Utils.snackBar('Password Updated', 'Successfully');
        } else if (value['error'] == 'user not found') {
          Utils.snackBar('Update Password', value['error']);
        } else if (value['error'] == 'Old password do not match') {
          Utils.snackBar('Invalid Password', value['error']);
        } else {
          Utils.snackBar('Error', 'Unknown error occurred');
        }
      }).onError((error, stackTrace) {
        Utils.snackBar('Error', error.toString());
      });
    } catch (e) {
      Utils.snackBar('Password Updated', 'An error occurred while password update');
      // Add logic here to display activity indicator and navigate back after 2 seconds

      return; // End the function
    }
  }

}
