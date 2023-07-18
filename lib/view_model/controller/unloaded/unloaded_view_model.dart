import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:celient_project/res/components/widgets/dialoge_box/dialoge_box_congrats.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:path/path.dart' as p;



import '../../../repository/upload_unloaded_repository/upload_unload_repository.dart';

class UnloadDataViewModel extends GetxController {
  final receiveByController = TextEditingController().obs;
  final receiveByFocusNode = FocusNode().obs;

  final _api = UploadLoadedRepository();

  RxString podPath = ''.obs;
  RxString unloadPlacePath = ''.obs;
  RxString signatureImagePath = RxString('');

  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
  );

  final GlobalKey imageKey = GlobalKey();
  Future<Uint8List?> captureSignature() async {
    try {
      final boundary = imageKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) {
        print('Error: RenderRepaintBoundary is null');
        return null;
      }

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        print('Error: Unable to convert image to byteData');
        return null;
      }

      final pngBytes = byteData.buffer.asUint8List();
      print('Image captured and converted to bytes');

      final directory = await getApplicationDocumentsDirectory();
      final signaturePath = '${directory.path}/signature.png';
      await File(signaturePath).writeAsBytes(pngBytes);

      signatureImagePath.value = signaturePath;

      return pngBytes;
    } catch (e) {
      print('Error capturing signature: $e');
      return null;
    }
  }





  void uploadUnLoadApi(String unloadPlace, String loadId) async {
    try {
      final signatureImagePath = this.signatureImagePath.value;
      final signaturePicFile = File(signatureImagePath); // Use the signature image path here

      if (!signaturePicFile.existsSync()) {
        print('Signature file does not exist at this path: $signatureImagePath');
        return; // Exit if the file doesn't exist
      }

      final signaturePicExtension = p.extension(signatureImagePath).replaceAll('.', '');
      final signaturePicBytes = await signaturePicFile.readAsBytes();
      final signaturePicBase64 = 'data:image/$signaturePicExtension;base64,${base64Encode(signaturePicBytes)}';

      final unloadPlacePicFile = File(unloadPlace);
      if (!unloadPlacePicFile.existsSync()) {
        print('Unload Place file does not exist at this path: $unloadPlace');
        return; // Exit if the file doesn't exist
      }

      final unloadPlacePicExtension = unloadPlace.split(".").last;
      final unloadPlacePicBytes = await unloadPlacePicFile.readAsBytes();
      final unloadPlacePicBase64 = 'data:image/$unloadPlacePicExtension;base64,${base64Encode(unloadPlacePicBytes)}';

      Map<String, dynamic> data = {
        'pod_pic': signaturePicBase64,
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
