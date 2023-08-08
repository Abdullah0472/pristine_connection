import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:celient_project/repository/upload_loaded_repository/upload_loaded_repository.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view_model/controller/current_trip/current_trip_view_model.dart';
import 'package:celient_project/view_model/controller/load_status_view_model/load_status_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

// ignore: camel_case_types
class loadDetailViewModel extends GetxController {
  final Completer<GoogleMapController> controller = Completer();
  final currentTripVM = Get.put(CurrentTripController());
  final pieceController = TextEditingController().obs;
  final totalWeightController = TextEditingController().obs;
  final bolNumberController = TextEditingController().obs;
  final unloadByController = TextEditingController().obs;

  final pieceFocusNode = FocusNode().obs;
  final totalWeightFocusNode = FocusNode().obs;
  final bolNumberFocusNode = FocusNode().obs;
  final unloadByFocusNode = FocusNode().obs;
  LoadStatusPreference loadStatuses = LoadStatusPreference();

  final _api = UploadLoadedRepository();

  final List<Rx<File>> imageFiles = [
    Rx<File>(File('')), // For the first container
    Rx<File>(File('')), // For the second container
    Rx<File>(File('')), // For the third container
    Rx<File>(File('')), // For the fourth container
    Rx<File>(File('')), // For the fifth container
    Rx<File>(File('')), // For the sixth container
    Rx<File>(File('')), // For the seventh container
    Rx<File>(File('')), // For the eighth container
    Rx<File>(File('')), // For the ninth container
    Rx<File>(File('')), // For the tenth container
    Rx<File>(File('')), // For the eleven container
    Rx<File>(File('')), // For the twelve container
    Rx<File>(File('')), // For the thirteen container
    Rx<File>(File('')), // For the fourteen container
    Rx<File>(File('')), // For the fifteen container
    Rx<File>(File('')), // For the sixteen container
    Rx<File>(File('')), // For the seventeen container
    Rx<File>(File('')), // For the eighteen container
    Rx<File>(File('')), // For the nineteen container
    Rx<File>(File('')), // For the twenty container
    Rx<File>(File('')), // For the twentyone container
    Rx<File>(File('')), // For the twentytwo container
    Rx<File>(File('')), // For the twentythree container
    Rx<File>(File('')), // For the twentyfour container
    Rx<File>(File('')), // For the twentyfive container
    Rx<File>(File('')), // For the twentysix container
    Rx<File>(File('')), // For the twentyseven container
  ];


  final picker = ImagePicker();


  RxString bolPicPath = ''.obs;
  RxString freightPicPath = ''.obs;


  Future<String> imgFromGallery(int containerIndex) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      String? croppedPath = await cropImage(File(pickedFile.path), containerIndex);
      print('Gallery Image Path: $croppedPath');
      return croppedPath ?? '';
    }

    return ''; // Return a default value if no image is selected
  }


  Future<String> imgFromCamera(int containerIndex) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      String? croppedPath = await cropImage(File(pickedFile.path), containerIndex);
      print('Camera Image Path: $croppedPath');
      return croppedPath ?? '';
    }

    return ''; // Return a default value if no image is captured
  }

  // Future<void> cropImage(File imgFile, int containerIndex) async
  Future<String?> cropImage(File imgFile, int containerIndex) async
  {
    // final croppedFile = await ImageCropper().cropImage
    final croppedFile = await ImageCropper().cropImage
      (
      sourcePath: imgFile.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Image Cropper",
          toolbarColor: AppColor.applicationColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: "Image Cropper",
        ),
      ],
    );


    if (croppedFile != null) {
      imageCache.clear();
      imageFiles[containerIndex].value = File(croppedFile.path);
      return croppedFile.path;  //returning the path of the cropped image
    }
    return null;


  }


  void uploadLoadApi(String bolPic, String freightPic, String loadId) async {
    try {
        final bolPicFile = File(bolPic);
        final bolPicExtension = bolPic.split(".").last;
        final bolPicBytes = await bolPicFile.readAsBytes();
        final bolPicBase64 = 'data:image/$bolPicExtension;base64,${base64Encode(bolPicBytes)}';
        final freightPicFile = File(freightPic);
        final freightPicExtension = freightPic.split(".").last;
        final freightPicBytes = await freightPicFile.readAsBytes();
        final freightPicBase64 = 'data:image/$freightPicExtension;base64,${base64Encode(freightPicBytes)}';

        Map<String, dynamic> data = {
          'bol_pic': bolPicBase64,
          'freight_pic': freightPicBase64,
          'load_id': loadId,
          'weight': totalWeightController.value.text,
          'pieces': pieceController.value.text,
          'bol_number': bolNumberController.value.text,
        };


      final response = await _api.uploadData(data);

      if (response['status_code'] == 200) {
        Utils.snackBar('Load Data Uploaded', 'Successfully');
        // loadStatuses
        //     .saveLoadStatus('in-transit')
        //     .then((value) {
        //   // You could do something here after saving, or simply do nothing
        // })
        //     .onError((error, stackTrace) {
        //   // Log or handle error here
        //   // setError(error.toString());
        // });

      } else {
        Utils.snackBar('Failed to Upload Load data', 'Server responded with status code: ${response['status_code']}');
        print('The error is Loading data  $response');
      }

    } catch (e) {
      Utils.snackBar('Failed to Upload Loading Data', 'An error occurred while uploading load data: ${e.toString()}');
      print('The error is Uploading load data  ${e.toString()}');
      return; // End the function
    }
  }



}
