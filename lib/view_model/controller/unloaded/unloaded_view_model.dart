import 'dart:convert';
import 'dart:io';

import 'package:celient_project/res/components/widgets/dialoge_box/dialoge_box_congrats.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/upload_unloaded_repository/upload_unload_repository.dart';

class UnloadDataViewModel extends GetxController {
  final receiveByController = TextEditingController().obs;

  final receiveByFocusNode = FocusNode().obs;

  final _api = UploadLoadedRepository();

  RxString podPath = ''.obs;
  RxString unloadPlacePath = ''.obs;

  void uploadUnLoadApi(String podPic, String unloadPlace, String loadId) async {
    try {
      final podPicFile = File(podPic);
      final podPicExtension = podPic.split(".").last;
      final podPicBytes = await podPicFile.readAsBytes();
      final podPicBase64 = 'data:image/$podPicExtension;base64,${base64Encode(podPicBytes)}';


      final unloadPlacePicFile = File(unloadPlace);
      final unloadPlacePicExtension = unloadPlace.split(".").last;
      final unloadPlacePicBytes = await unloadPlacePicFile.readAsBytes();
      final unloadPlacePicBase64 = 'data:image/$unloadPlacePicExtension;base64,${base64Encode(unloadPlacePicBytes)}';

      Map<String, dynamic> data = {
        'pod_pic': podPicBase64,
        'unload_place_pic': unloadPlacePicBase64,
        'load_id': loadId,
        'recieve_by': receiveByController.value.text,

      };


      final response = await _api.uploadUnloadData(data);

      if (response['status_code'] == 200) {
        Utils.snackBar('UnLoad Data Uploaded', 'Successfully');

        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return DialogeBoxCongrats();
          },
        );

      } else {
        Utils.snackBar('Failed to Upload UnLoad data', 'Server responded with status code: ${response['status_code']}');
        print('The error is Loading data  $response');
      }

    } catch (e) {
      Utils.snackBar('Failed to Upload Loading Data', 'An error occurred while uploading load data: ${e.toString()}');
      print('The error is Uploading Unload data  ${e.toString()}');
      return; // End the function
    }
  }


}
