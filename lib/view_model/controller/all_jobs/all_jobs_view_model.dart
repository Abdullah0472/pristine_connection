import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AllJobViewModel extends GetxController {

  final radiusController = TextEditingController().obs;
  final postalCodeController = TextEditingController().obs;
  final bidController = TextEditingController().obs;

  RxString price = '0'.obs;

  void updatePrice(String newPrice) {
    price.value = newPrice;
  }



  final radiusFocusNode = FocusNode().obs;
  final postalCodeFocusNode = FocusNode().obs;
  final bidFocusNode = FocusNode().obs;




}