import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/dialoge_box/dialoge_box_confirmation.dart';
import 'package:celient_project/view/load_info/load_info_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonController extends GetxController {
  Rx<Widget> button = Rx<Widget>(Container());

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
    button.value = RoundButton(
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
