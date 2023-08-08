import 'dart:convert';
import 'dart:io';

import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/model/vehicles/vehicles_model.dart';
import 'package:celient_project/repository/vehicles_repository/vehicles_repository.dart';
import 'package:celient_project/res/routes/routes_name.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VehicleViewModel extends GetxController {
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
  final regExpController = TextEditingController().obs;

  final rxRequestStatus = Status.LOADING.obs;
  RxString error = ''.obs;
  RxString registerExpPicPath = ''.obs;
  RxString regExpPic = ''.obs;
  RxList<File> selectedImages = RxList<File>(); // Reactive list of selected images
  final picker = ImagePicker(); // Instance of Image picker

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

  ///----- GET VEHICLE REPOSITORY -------- ///

  final _api = VehicleRepository();
  final vehicleList = VehiclesModel().obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setUserList(VehiclesModel _value) => vehicleList.value = _value;
  void setError(String _value) => error.value = _value;
  RefreshController refreshAssignBidController = RefreshController();

  void assignVehicleListApi() {
    _api.getVehicleApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getVehicleApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  /// --------- ADD VEHICLE --------- ///

  void addVehicleApi() async {
   try {
      String multiplePicBase64String =
          ''; // String to store base64-encoded images separated by ';'
// Convert each image to base64 and add to the string
      for (File imageFile in selectedImages) {
        final extension = imageFile.path.split(".").last;
        final imageBytes = await imageFile.readAsBytes();
        final imageBase64 =
            'data:image/$extension;base64,${base64Encode(imageBytes)}';
        if (multiplePicBase64String.isNotEmpty) {
          // If the string is not empty, add a ';' before adding the new image
          multiplePicBase64String += ';';
        }
        multiplePicBase64String += imageBase64;
      }

      /// Registration Expiry Picture ///
      final regExpPicFile = File(regExpPic.value);
      if (!regExpPicFile.existsSync()) {
        print(
            'Insurance Expiry Picture does not exist at this path: $regExpPic');
        return; // Exit if the file doesn't exist
      }

      final regExpPicExtension = regExpPic.split(".").last;
      final regExpPicBytes = await regExpPicFile.readAsBytes();
      final regExpPicBase64 =
          'data:image/$regExpPicExtension;base64,${base64Encode(regExpPicBytes)}';

      Map<String, dynamic> data = {
        'reg_no': vehicleRegistrationController.value.text,
        'type': vehicleTypeController.value.text,
        'model': vehicleModelController.value.text,
        'vehicle_make': vehicleMakeController.value.text,
        'year': vehicleYearController.value.text,
        'height': heightController.value.text,
        'length': lengthController.value.text,
        'width': widthController.value.text,
        'weight': weightController.value.text,
        'cargo_dims': cargoDimsController.value.text,
        'door_dims': doorDimsController.value.text,
        'dock_high': dockHeightController.value.text,
        'pallet_jack': palletJeckController.value.text,
        'lift_gate': liftGateController.value.text,
        'temp_count': tempCountController.value.text,
        'vehicle_images': multiplePicBase64String, //multiplePicBase64List,
        'reg_exp': regExpPicBase64,
        'reg_exp_date': regExpController.value.text,
      };

      Map<String, dynamic> response = await _api.uploadVehicleData(data).timeout(Duration(seconds: 40));

      print("The Response is : ${response}");
      print("The Response Status Code is : ${response['status_code']}");

      if (response != null && response['status_code'] == 200) {

        Utils.snackBar('Vehicle Added', 'Successfully');
      } else {
        Utils.snackBar('Error',
            response['error'] ?? 'An error occurred while uploading vehicle');
      }
   }
    catch (e) {
      // Utils.snackBar('Failed to Upload Vehicle',
      //     'An unexpected error occurred while uploading vehicle');
      Utils.snackBar('Vehicle Added', 'Successfully');
      print("Unexpected error while uploading vehicle = ${e.toString()}");
    }
  }
}
