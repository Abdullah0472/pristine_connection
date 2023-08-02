import 'dart:async';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/cards/load_detail_card.dart';
import 'package:celient_project/res/components/widgets/cards/load_detail_generalInfo_card.dart';
import 'package:celient_project/res/components/widgets/cards/load_detail_route_card.dart';
import 'package:celient_project/res/components/widgets/dialoge_box/dialoge_box_confirmation.dart';
import 'package:celient_project/res/components/widgets/dialoge_box/dialogue_box_deliver_confirmation.dart';
import 'package:celient_project/view/load_info/load_info_view.dart';
import 'package:celient_project/view/unloaded/unloaded_view.dart';
import 'package:celient_project/view_model/controller/button/button_view_model.dart';
import 'package:celient_project/view_model/controller/current_trip/current_trip_view_model.dart';
import 'package:celient_project/view_model/controller/load_status_view_model/load_status_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LoadDetailView extends StatefulWidget {
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

  @override
  State<LoadDetailView> createState() => _LoadDetailViewState();
}

class _LoadDetailViewState extends State<LoadDetailView> {
  final ButtonController buttonController = Get.put(ButtonController());

  final currentTripVM = Get.put(CurrentTripController());

  LoadStatusPreference loadStatuspre = LoadStatusPreference();

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    startTimer();
  }


  @override
  void dispose() {
    // Cancel the timer and close the stream when the widget is disposed
    _timer?.cancel();
    loadStatuspre.dispose();
    super.dispose();
  }

  void startTimer() {
    // Schedule a timer to call refreshApi() every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      currentTripVM.refreshApi();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              dateTime: widget.dateTime,
              loadId: widget.loadId,
              currentAddress: widget.currentAddress,
              pieces: widget.piece,
              dims: widget.dims,
              weight: widget.weight,
            ),
            const SizedBox(
              height: 20,
            ),
            LoadDetailGeneralInfoCards(
              pieces: widget.piece,
              weight: widget.weight,
              miles: widget.miles,
            ),
            const SizedBox(
              height: 20,
            ),
            LoadDetailRouteCard(
              pickupName: widget.pickupName,
              pickupAddress: widget.pickupAddress,
              pickupDateTime: widget.pickupDateTime,
              piece: widget.piece,
              dims: widget.dims,
              weight: widget.weight,
              deliveryName: widget.deliveryName,
              deliveryAddress: widget.deliveryAddress,
              deliveryTime: widget.deliveryDateTime,
            ),
            SizedBox(
              height: 40,
            ),
            StreamBuilder<String>(
              //stream: loadStatuspre.loadStatusStream,
              stream: currentTripVM.loadStatuses.loadStatusStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    final loadStatus = snapshot.data;
                    // Handle the load status and return the appropriate button
                    switch (loadStatus?.trim()) {
                      case 'started':
                        print(loadStatus);
                        return RoundButton(
                          loading: false,
                          width: 300,
                          height: Get.height * 0.06,
                          onPress:  () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogeBoxConfirmation(
                                  deliverAddress: widget.deliveryAddress,
                                  title: 'Did you arrive to the Pick-up Address Below?',
                                  pickupAddress: widget.pickupAddress,
                                  piece: widget.piece,
                                  totalWeight: widget.weight,
                                  loadId: widget.loadId,
                                  status: 'pickup',
                                );
                              },
                            );
                          },
                          title: 'Arrived to Pick-up',
                        );

                      case 'pickup':
                        return RoundButton(
                          loading: false,
                          width: 300,
                          height: Get.height * 0.06,
                          onPress:  () {
                            Get.to(
                                  () => LoadInfoView(
                                loadId: widget.loadId,
                                piece: widget.piece,
                                totalWeight: widget.weight,
                                deliverAddress: widget.deliveryAddress,
                              ),
                            );

                          },
                          title: 'Loaded',
                        );

                      case 'in-transit':
                        return RoundButton(
                          loading: false,
                          width: 300,
                          height: Get.height * 0.06,
                          onPress:  () {
                            Future.delayed(Duration.zero, () {
                              showDialog(
                                context: Get.overlayContext!,
                                builder: (BuildContext dialogContext) {
                                  return DialogeBoxDeliveryConfirmation(
                                    loadId: widget.loadId,
                                    status: 'customer',
                                    title:
                                    'Did you arrive to the Deliver Address Below?',
                                    piece: widget.piece,
                                    totalWeight: widget.weight,
                                    deliverAddress: widget.deliveryAddress,
                                  );
                                },
                              );
                            });

                          },
                          title: 'Arrived to Delivery',
                        );

                      case 'customer':

                        return RoundButton(
                          loading: false,
                          width: 300,
                          height: Get.height * 0.06,
                          onPress:  () {
                            Get.to(() => UnloadedView(loadId: widget.loadId,));
                            // Get.back();
                          },
                          title: 'Unloaded',
                        );

                      default:
                        return RoundButton(
                          loading: false,
                          width: 300,
                          height: Get.height * 0.06,
                          onPress:  () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogeBoxConfirmation(
                                  deliverAddress: widget.deliveryAddress,
                                  title: 'Did you arrive to the Pick-up Address Below?',
                                  pickupAddress: widget.pickupAddress,
                                  piece: widget.piece,
                                  totalWeight: widget.weight,
                                  loadId: widget.loadId,
                                  status: 'pickup',
                                );
                              },
                            );
                          },
                          title: 'Arrived to Pick-up',
                        );

                    }
                  } else if (snapshot.hasError) {
                    // Handle the error state
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Handle the initial loading state
                    return CircularProgressIndicator();
                  }
                } else {
                  // Handle other connection states, if necessary
                  return Text('Connection state: ${snapshot.connectionState}');
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
