import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/cards/load_detail_card.dart';
import 'package:celient_project/res/components/widgets/cards/load_detail_generalInfo_card.dart';
import 'package:celient_project/res/components/widgets/cards/load_detail_route_card.dart';
import 'package:celient_project/res/components/widgets/dialoge_box/dialoge_box_confirmation.dart';
import 'package:celient_project/view_model/controller/button/button_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadDetailView extends StatelessWidget {
  final String refNumber;
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
      required this.refNumber,
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

  @override
  Widget build(BuildContext context) {
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
              refNumber: refNumber,
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

            // RoundButton(
            //   loading: false,
            //   width: 300,
            //   height: Get.height * 0.06,
            //   onPress: () {
            //     showDialog(
            //       context: context,
            //       builder: (BuildContext context) {
            //         return  DialogeBoxConfirmation(
            //          pickupAddress: pickupAddress,
            //         );
            //       },
            //     );
            //   },
            //   title: 'Arrived to Pick-up',
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
