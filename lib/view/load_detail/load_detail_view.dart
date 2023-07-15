import 'package:celient_project/model/current_trip/current_trip_model.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/cards/load_detail_card.dart';
import 'package:celient_project/res/components/widgets/cards/load_detail_generalInfo_card.dart';
import 'package:celient_project/res/components/widgets/cards/load_detail_route_card.dart';
import 'package:celient_project/res/components/widgets/dialoge_box/dialoge_box_confirmation.dart';
import 'package:celient_project/view_model/controller/button/button_view_model.dart';
import 'package:celient_project/view_model/controller/current_trip/current_trip_view_model.dart';
import 'package:celient_project/view_model/controller/load_status_view_model/load_status_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadDetailView extends StatelessWidget {
  final String loadId;
  final String currentAddress;
  final String dateTime;
  final String piece;
  final String dims;
  final String weight;
  final String miles;
  final String pickupName;
  final String pickupAddress;
  final String pickupDateTime;
  final String deliveryName;
  final String deliveryAddress;
  final String deliveryDateTime;
  LoadDetailView(
      {Key? key,
      required this.loadId,
      required this.currentAddress,
      required this.dateTime,
      required this.piece,
      required this.dims,
      required this.weight,
      required this.miles,
      required this.pickupName,
      required this.pickupAddress,
      required this.pickupDateTime,
      required this.deliveryName,
      required this.deliveryAddress,
      required this.deliveryDateTime})
      : super(key: key);

  final ButtonController buttonController = Get.put(ButtonController());
  final currentTripVM = Get.put(CurrentTripController());
  LoadStatusPrefernce loadStatuses = LoadStatusPrefernce();
  @override
  Widget build(BuildContext context) {
    // final loadStatus = currentTripVM.currentTripList.value.data![0].loadStatus;
// final loadStatus = loadStatuses.getLoadStatus();
// Future<void> updatedButton() async {
//   final loadStatus = await loadStatuses.getLoadStatus();
//
//   // Add your switch-case logic here to update the button based on the loadStatus
//   switch (loadStatus) {
//     case 'started':
//       buttonController.setInitialButton(() {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return DialogeBoxConfirmation(
//               deliverAddress: deliveryAddress,
//               title: 'Did you arrive to the Pick-up Address Below?',
//               pickupAddress: pickupAddress,
//               piece: piece,
//               totalWeight: weight,
//               loadId: loadId,
//               status: 'pickup',
//             );
//           },
//         );
//       });
//       break;
//     case 'pickup':
//       buttonController.buildUpdatedButton(() {
//         // Handle the button press for 'pickup' load status
//       });
//       break;
//     case 'in-transit':
//       buttonController.buildArrivedButton(() {
//         // Handle the button press for 'in-transit' load status
//       });
//       break;
//     case 'customer':
//       buttonController.buildUnloadButton(() {
//         // Handle the button press for 'customer' load status
//       });
//       break;
//     default:
//       buttonController.setInitialButton(() {
//         // Handle the button press for other load statuses
//       });
//       break;
//   }
// }

buttonController.setInitialButton(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogeBoxConfirmation(
            deliverAddress: deliveryAddress,
            title: 'Did you arrive to the Pick-up Address Below?',
            pickupAddress: pickupAddress,
            piece: piece,
            totalWeight: weight,
            loadId: loadId,
            status: 'pickup',
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: AppColor.offWhite,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            LoadDetailCards(
              dateTime: dateTime,
              loadId: loadId,
              currentAddress: currentAddress,
              pieces: piece,
              dims: dims,
              weight: weight,
            ),
            const SizedBox(
              height: 20,
            ),
            LoadDetailGeneralInfoCards(
              pieces: piece,
              weight: weight,
              miles: miles,
            ),
            const SizedBox(
              height: 20,
            ),
            LoadDetailRouteCard(
              pickupName: pickupName,
              pickupAddress: pickupAddress,
              pickupDateTime: pickupDateTime,
              piece: piece,
              dims: dims,
              weight: weight,
              deliveryName: deliveryName,
              deliveryAddress: deliveryAddress,
              deliveryTime: deliveryDateTime,
            ),
            SizedBox(
              height: 40,
            ),

              Obx(() => buttonController.button.value),

            // FutureBuilder<String?>(
            //   future: loadStatuses.getLoadStatus(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return CircularProgressIndicator();
            //     } else if (snapshot.hasError) {
            //       // Handle error case
            //       return Text('Error: ${snapshot.error}');
            //     } else {
            //       final loadStatus = snapshot.data;
            //
            //       // Add your switch-case logic here to update the button based on the loadStatus
            //       switch (loadStatus) {
            //         case 'started':
            //           print(loadStatus);
            //           buttonController.setInitialButton(() {
            //             showDialog(
            //               context: context,
            //               builder: (BuildContext context) {
            //                 return DialogeBoxConfirmation(
            //                   deliverAddress: deliveryAddress,
            //                   title: 'Did you arrive to the Pick-up Address Below?',
            //                   pickupAddress: pickupAddress,
            //                   piece: piece,
            //                   totalWeight: weight,
            //                   loadId: loadId,
            //                   status: 'pickup',
            //                 );
            //               },
            //             );
            //             loadStatuses
            //                 .saveLoadStatus('pickup')
            //                 .then((value) {
            //               // You could do something here after saving, or simply do nothing
            //             })
            //                 .onError((error, stackTrace) {
            //               // Log or handle error here
            //              // setError(error.toString());
            //             });
            //           });
            //           break;
            //         case 'pickup':
            //           buttonController.buildUpdatedButton(() {
            //             // Handle the button press for 'pickup' load status
            //           });
            //           break;
            //         case 'in-transit':
            //           buttonController.buildArrivedButton(() {
            //             // Handle the button press for 'in-transit' load status
            //           });
            //           break;
            //         case 'customer':
            //           buttonController.buildUnloadButton(() {
            //             // Handle the button press for 'customer' load status
            //           });
            //           break;
            //         default:
            //           buttonController.setInitialButton(() {
            //             showDialog(
            //               context: context,
            //               builder: (BuildContext context) {
            //                 return DialogeBoxConfirmation(
            //                   deliverAddress: deliveryAddress,
            //                   title:
            //                       'Did you arrive to the Pick-up Address Below?',
            //                   pickupAddress: pickupAddress,
            //                   piece: piece,
            //                   totalWeight: weight,
            //                   loadId: loadId,
            //                   status: 'pickup',
            //                 );
            //               },
            //             );
            //             loadStatuses.saveLoadStatus('pickup').then((value) {
            //               // You could do something here after saving, or simply do nothing
            //             }).onError((error, stackTrace) {
            //               // Log or handle error here
            //               // setError(error.toString());
            //             });
            //           });
            //           break;
            //       }
            //
            //       return SizedBox(
            //         height: 20,
            //       );
            //     }
            //   },
            // ),

            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
