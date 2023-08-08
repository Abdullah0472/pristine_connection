import 'dart:convert';
import 'dart:io';
import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/repository/update_bank/update_bank.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BankAccountViewModel extends GetxController {

  final bankNameController = TextEditingController().obs;
  final accountNameController = TextEditingController().obs;
  final routingController = TextEditingController().obs;
  final accountNumberController = TextEditingController().obs;

  final _api = BankRepository();
  final rxRequestStatus = Status.LOADING.obs;
  RxString error = ''.obs;
  RxString bankAccountPicPath = ''.obs;
  /// --------- ADD Bank Account --------- ///

  void updateBankAccountApi() async {
    try {


      /// Bank Document Picture ///
      final bankAccountPicFile = File(bankAccountPicPath.value);
      if (!bankAccountPicFile.existsSync()) {
        print(
            'Account Pic does not exist at this path: $bankAccountPicPath');
        return; // Exit if the file doesn't exist
      }

      final bankAccountExtension = bankAccountPicPath.split(".").last;
      final bankAccountBytes = await bankAccountPicFile.readAsBytes();
      final bankAccountPicBase64 = 'data:image/$bankAccountExtension;base64,${base64Encode(bankAccountBytes)}';

      Map<String, dynamic> data = {
        'bank_name': bankNameController.value.text,
        'account_name': accountNameController.value.text,
        'account_number': accountNumberController.value.text,
        'bank_docs': bankAccountPicBase64,
        'routing': routingController.value.text,

      };

      Map<String, dynamic> response = await _api.updateBankAccount(data);

      if (response != null && response['status_code'] == 200) {

        Utils.snackBar('Bank Account Details Uploaded', 'Successfully');
      } else {
        Utils.snackBar('Error',
            response['error'] ?? 'An error occurred while uploading bank account details');
        print('The Error is ${response['error']}');
      }
    }
    catch (e) {
      Utils.snackBar('Failed to Upload Bank Account Details',
          'An unexpected error occurred while uploading vehicle');

      print("Unexpected error while uploading vehicle = ${e.toString()}");
    }
  }

}
