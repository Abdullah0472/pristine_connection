import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfileViewModel extends GetxController {

  final emailController = TextEditingController().obs;
  final phoneNumberController = TextEditingController().obs;
  final licenceNumberController = TextEditingController().obs;
  final truckNumberController = TextEditingController().obs;


  final emailFocusNode = FocusNode().obs;
  final licenceNumberFocusNode = FocusNode().obs;
  final phoneNumberFocusNode = FocusNode().obs;
  final truckNumberFocusNode = FocusNode().obs;



}
