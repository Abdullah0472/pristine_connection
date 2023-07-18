import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/view_model/controller/current_trip/current_trip_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ButtonController extends GetxController {
  Rx<Widget> button = Rx<Widget>(Container());
  final currentTripVM = Get.put(CurrentTripController());


  void setInitialButton(void Function() onPressAction) {
    button.value = RoundButton(
      loading: false,
      width: 300,
      height: Get.height * 0.06,
      onPress: onPressAction,
      title: 'Arrived to Pick-up',
    );
  }

  void buildUpdatedButton(void Function() onPressAction) {
    button.value = RoundButton(
      loading: false,
      width: 300,
      height: Get.height * 0.06,
      onPress: onPressAction,
      title: 'Loaded',
    );
  }

  void buildArrivedButton(void Function() onPressAction) {
    button.value =  RoundButton(
      loading: false,
      width: 300,
      height: Get.height * 0.06,
      onPress: onPressAction,
      title: 'Arrived to Delivery',
    );
  }

  void buildUnloadButton(void Function() onPressAction) {
    button.value = RoundButton(
      loading: false,
      width: 300,
      height: Get.height * 0.06,
      onPress: onPressAction,
      title: 'Unloaded',
    );
  }

}

