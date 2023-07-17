import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/dialoge_box/dialoge_box_confirmation.dart';
import 'package:celient_project/view_model/controller/current_trip/current_trip_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// class ButtonController extends GetxController {
//   Rx<Widget> button = Rx<Widget>(Container());
//   final currentTripVM = Get.put(CurrentTripController());
//
//   void setInitialButton(void Function() onPressAction) {
//     button.value = RoundButton(
//       loading: false,
//       width: 300,
//       height: Get.height * 0.06,
//       onPress: onPressAction,
//       title: 'Arrived to Pick-up',
//     );
//   }
//
//
//
//
//   void buildUpdatedButton(void Function() onPressAction) {
//     button.value = RoundButton(
//       loading: false,
//       width: 300,
//       height: Get.height * 0.06,
//       onPress: onPressAction,
//       title: 'Loaded',
//     );
//   }
//
//   void buildArrivedButton(void Function() onPressAction) {
//     button.value = RoundButton(
//       loading: false,
//       width: 300,
//       height: Get.height * 0.06,
//       onPress: onPressAction,
//       title: 'Arrived to Delivery',
//     );
//   }
//
//   void buildUnloadButton(void Function() onPressAction) {
//     button.value = RoundButton(
//       loading: false,
//       width: 300,
//       height: Get.height * 0.06,
//       onPress: onPressAction,
//       title: 'Unloaded',
//     );
//   }
//
//   // void updateButton() {
//   //   // Assuming that you have access to currentTripVM in ButtonController
//   //   String? loadStatus = currentTripVM.currentTripList.value.data![0].loadStatus;
//   //
//   //   void Function() onPressAction = () {}; // Define this function based on your application logic
//   //
//   //   switch (loadStatus) {
//   //     case 'pickup':
//   //       buildUpdatedButton(onPressAction);
//   //       break;
//   //     case 'loaded':
//   //       buildArrivedButton(onPressAction);
//   //       break;
//   //     case 'delivered':
//   //       buildUnloadButton(onPressAction);
//   //       break;
//   //     default:
//   //       setInitialButton(onPressAction);
//   //       break;
//   //   }
//   // }
//
//
//   void updateButton() {
//     String? loadStatus = currentTripVM.currentTripList.value.data![0].loadStatus;
//
//     onPressAction() {
//       // Perform some action based on the load status
//       if (loadStatus == 'started') {
//         // Handle the 'pickup' case
//       } else if (loadStatus == 'pickup') {
//         // Handle the 'loaded' case
//       } else if (loadStatus == 'loaded') {
//         // Handle the 'delivered' case
//       } else {
//         // Handle other cases
//       }
//     }
//
//     // Update the button based on the load status and onPressAction
//     // You can use the appropriate button method based on the load status
//     switch (loadStatus) {
//       case 'started':
//         setInitialButton(onPressAction);
//         break;
//       case 'pickup':
//         buildUpdatedButton(onPressAction);
//         break;
//       case 'delivered':
//         buildUnloadButton(onPressAction);
//         break;
//       default:
//         setInitialButton(onPressAction);
//         break;
//     }
//   }
//
//
// }

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


// void updateButton() {
//   final loadStatus = currentTripVM.currentTripList.value.data![0].loadStatus;
//   switch (loadStatus) {
//     case 'started':
//       setInitialButton(() {
//         // Handle the button press for 'started' load status
//       });
//       break;
//     case 'pickup':
//       buildUpdatedButton(() {
//         // Handle the button press for 'pickup' load status
//       });
//       break;
//     case 'in-transit':
//       buildArrivedButton(() {
//         // Handle the button press for 'loaded' load status
//       });
//       break;
//     case 'customer':
//       buildUnloadButton(() {
//         // Handle the button press for 'delivered' load status
//       });
//       break;
//     default:
//       setInitialButton(() {
//         // Handle the button press for other load statuses
//       });
//       break;
//   }
// }