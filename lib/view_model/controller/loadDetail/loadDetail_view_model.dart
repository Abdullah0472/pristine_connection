import 'dart:async';
import 'dart:io';

import 'package:celient_project/res/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class loadDetailViewModel extends GetxController {
  final Completer<GoogleMapController> controller = Completer();

  final pieceController = TextEditingController().obs;
  final totalWeightController = TextEditingController().obs;
  final bolNumberController = TextEditingController().obs;
  final unloadByController = TextEditingController().obs;

  final pieceFocusNode = FocusNode().obs;
  final totalWeightFocusNode = FocusNode().obs;
  final bolNumberFocusNode = FocusNode().obs;
  final unloadByFocusNode = FocusNode().obs;

  final List<Rx<File>> imageFiles = [
    Rx<File>(File('')), // For the first container
    Rx<File>(File('')), // For the second container
    Rx<File>(File('')), // For the third container
    Rx<File>(File('')), // For the fourth container

  ];


  final picker = ImagePicker();

  Future<void> imgFromGallery(int containerIndex) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      await cropImage(File(pickedFile.path), containerIndex);
    }
  }

  Future<void> imgFromCamera(int containerIndex) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      await cropImage(File(pickedFile.path), containerIndex);
    }
  }

  Future<void> cropImage(File imgFile, int containerIndex) async {
    final croppedFile = await ImageCropper().cropImage(
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
    }


  }
}
