
import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/repository/user_profile_repository/user_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleViewModel extends GetxController {

  final vehicleTypeController = TextEditingController().obs;
  final weightController = TextEditingController().obs;
  final heightController = TextEditingController().obs;
  final lengthController = TextEditingController().obs;
  final widthController = TextEditingController().obs;
  final registrationNumberController = TextEditingController().obs;
  final palletsController = TextEditingController().obs;


 // final _api = UserProfileRepository();

  final rxRequestStatus = Status.LOADING.obs;
  //final userList = UserModel().obs;
  RxString error = ''.obs;

  RxString image1Path = ''.obs;
  RxString image2Path = ''.obs;
  RxString image3Path = ''.obs;
  RxString image4Path = ''.obs;
  RxString image5Path = ''.obs;
  RxString image6Path = ''.obs;
  RxString image7Path = ''.obs;
  RxString image8Path = ''.obs;
  RxString image9Path = ''.obs;
  RxString image10Path = ''.obs;
  RxString image11Path = ''.obs;
  RxString image12Path = ''.obs;


  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  //void setUserList(UserModel _value) => userList.value = _value;
  void setError(String _value) => error.value = _value;

}