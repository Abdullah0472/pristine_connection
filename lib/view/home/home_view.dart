// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/cards/load_cards.dart';
import 'package:celient_project/res/components/widgets/exception/general_exception.dart';
import 'package:celient_project/res/components/widgets/exception/internet_exceptions_widget.dart';
import 'package:celient_project/res/routes/routes_name.dart';
import 'package:celient_project/view_model/controller/assign_bids/asign_bids_view_model.dart';
import 'package:celient_project/view_model/controller/current_trip/current_trip_view_model.dart';
import 'package:celient_project/view_model/controller/profile/profile_view_model.dart';
import 'package:celient_project/view_model/controller/start_trip/start_trip_view_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../model/current_trip/current_trip_model.dart';

class HomeView extends StatefulWidget {

  const HomeView({

    Key? key,
  }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}


class _HomeViewState extends State<HomeView> {
  final Completer<GoogleMapController> _controller = Completer();
  String mapTheme = '';
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(24.88453, 67.07886),
    zoom: 15,
  );
  final List<Marker> _markers = <Marker>[];
  final currentTripVM = Get.put(CurrentTripController());
  final profileVM = Get.put(ProfileViewModel());
  @override
  void initState() {
    super.initState();
    currentTripVM.currentTripListApi();
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/retro_theme.json')
        .then((value) {
      mapTheme = value;
    });
    loadData();

  }


  loadData() {
    getUserCurrentLocation().then((value) async {
      // _markers.add(
      //   Marker(
      //     markerId: const MarkerId('2'),
      //     position: LatLng(
      //       value.latitude,
      //       value.longitude,
      //     ),
      //     infoWindow: const InfoWindow(
      //       title: "Your Current Location",
      //     ),
      //   ),
      // );
      CameraPosition cameraPosition = CameraPosition(
        zoom: 18,
        target: LatLng(
          value.latitude,
          value.longitude,
        ),
      );

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {});
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('error$error');
    });
    return await Geolocator.getCurrentPosition();
  }

  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        icon: true,
        actionIcon: true,
        action: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  _controller.future.then(
                    (value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/maptheme/silver_theme.json')
                          .then(
                        (string) {
                          value.setMapStyle(string);
                        },
                      );
                    },
                  );
                },
                child: const Text('Silver'),
              ),
              PopupMenuItem(
                onTap: () {
                  _controller.future.then(
                    (value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/maptheme/retro_theme.json')
                          .then(
                        (string) {
                          value.setMapStyle(string);
                        },
                      );
                    },
                  );
                },
                child: const Text('Retro'),
              ),
              PopupMenuItem(
                onTap: () {
                  _controller.future.then(
                    (value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/maptheme/night_theme.json')
                          .then(
                        (string) {
                          value.setMapStyle(string);
                        },
                      );
                    },
                  );
                },
                child: const Text('Night'),
              ),
            ],
          )
        ],
        title: 'Trips on Going',
        leadingIcon: IconButton(
          onPressed: () {
            Get.toNamed(RouteName.allJobVIew);
          },
          icon: const Icon(
            MdiIcons.tag,
            size: 30,
            color: AppColor.blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(alignment: AlignmentDirectional.center, children: [
          GoogleMap(
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            top: 60,
            child:
            // Obx((){
            //   switch(currentTripVM.rxRequestStatus.value){
            //     case Status.LOADING:
            //       return const Center(child: CircularProgressIndicator());
            //     case Status.ERROR:
            //       if(currentTripVM.error.value =='No internet'){
            //         return InterNetExceptionWidget(onPress: () {
            //           currentTripVM.refreshApi();
            //         },);
            //       }
            //       else {
            //         return GeneralExceptionWidget(onPress: (){
            //           currentTripVM.refreshApi();
            //         });
            //       }
            //     case Status.COMPLETED:
            //       return Container(
            //          height: Get.height*0.5,
            //         width: Get.width *0.9,
            //         child: ListView.builder(
            //             itemCount: currentTripVM.currentTripList.value.data?.length ?? 0,
            //             itemBuilder: (context, index){
            //               return
            //              //   currentTripVM.currentTripList.value.data![index].loadStatus == 'started'?
            //                 LoadCards(
            //                   loadId: currentTripVM.currentTripList.value.data![index].loadId.toString(),
            //                   dateTime: currentTripVM.currentTripList.value.data?[index].pickupDate??"",
            //                   piece:currentTripVM.currentTripList.value.data![index].pieces.toString(),
            //                   dims: currentTripVM.currentTripList.value.data?[index].dims??"",
            //                   weight: currentTripVM.currentTripList.value.data![index].weight.toString(),
            //                   miles: currentTripVM.currentTripList.value.data![index].miles.toString(),
            //                   pickupName: '',
            //                   // profileVM.userList.value.data!.name??'',
            //                   pickupAddress: currentTripVM.currentTripList.value.data![index].pickupLocation??"",
            //                   pickupDateTime: currentTripVM.currentTripList.value.data![index].pickupDate??"",
            //                   deliveryName: '',
            //                   deliveryAddress:currentTripVM.currentTripList.value.data![index].deliveryLocation??"",
            //                   deliveryDateTime: currentTripVM.currentTripList.value.data![index].deliveryDate??"",
            //                 );
            //               // :
            //               //   SizedBox();
            //             }
            //         ),
            //       );
            //   }
            // }),

            Obx(() {
              switch (currentTripVM.rxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  if (currentTripVM.error.value == 'No internet') {
                    return InterNetExceptionWidget(
                      onPress: () {
                        currentTripVM.refreshApi();
                      },
                    );
                  } else {
                    return GeneralExceptionWidget(
                      onPress: () {
                        currentTripVM.refreshApi();
                      },
                    );
                  }
                case Status.COMPLETED:
                  if (currentTripVM.currentTripList.value.data != null && currentTripVM.currentTripList.value.data!.isNotEmpty) {
                    return Container(
                      height: Get.height * 0.5,
                      width: Get.width * 0.9,
                      child: ListView.builder(
                        itemCount: currentTripVM.currentTripList.value.data!.length,
                        itemBuilder: (context, index) {
                          return LoadCards(
                            loadId: currentTripVM.currentTripList.value.data![index].loadId.toString(),
                            dateTime: currentTripVM.currentTripList.value.data?[index].pickupDate ?? "",
                            piece: currentTripVM.currentTripList.value.data![index].pieces.toString(),
                            dims: currentTripVM.currentTripList.value.data?[index].dims ?? "",
                            weight: currentTripVM.currentTripList.value.data![index].weight.toString(),
                            miles: currentTripVM.currentTripList.value.data![index].miles.toString(),
                            pickupName: '',
                            pickupAddress: currentTripVM.currentTripList.value.data![index].pickupLocation ?? "",
                            pickupDateTime: currentTripVM.currentTripList.value.data![index].pickupDate ?? "",
                            deliveryName: '',
                            deliveryAddress: currentTripVM.currentTripList.value.data![index].deliveryLocation ?? "",
                            deliveryDateTime: currentTripVM.currentTripList.value.data![index].deliveryDate ?? "",
                          );
                        },
                      ),
                    );
                  } else {
                    return Container(
                      height: Get.height * 0.5,
                      width: Get.width * 0.9,
                      child: Center(
                        child: Text(''),
                      ),
                    );
                  }
              }
            }),

            // Obx(() {
            //   switch (currentTripVM.rxRequestStatus.value) {
            //     case Status.LOADING:
            //       return const Center(child: CircularProgressIndicator());
            //     case Status.ERROR:
            //       if (currentTripVM.error.value == 'No internet') {
            //         return InterNetExceptionWidget(
            //           onPress: () {
            //             currentTripVM.refreshApi();
            //           },
            //         );
            //       }
            //       else {
            //         return
            //
            //           GeneralExceptionWidget(
            //           onPress: () {
            //             currentTripVM.refreshApi();
            //           },
            //         );
            //       }
            //     case Status.COMPLETED:
            //       final List<Data>? tripData = currentTripVM.currentTripList.value.data;
            //       if (tripData != null || tripData?.isNotEmpty || tripData[0] != null) {
            //         return Container(
            //           height: Get.height * 0.5,
            //           width: Get.width * 0.9,
            //           child: ListView.builder(
            //             itemCount: tripData.length,
            //             itemBuilder: (context, index) {
            //               final currentTrip = tripData[index];
            //               if (currentTrip != null) {
            //                 return LoadCards(
            //                   loadId: currentTrip.loadId.toString(),
            //                   dateTime: currentTrip.pickupDate ?? "",
            //                   piece: currentTrip.pieces.toString(),
            //                   dims: currentTrip.dims ?? "",
            //                   weight: currentTrip.weight.toString(),
            //                   miles: currentTrip.miles.toString(),
            //                   pickupName: '',
            //                   pickupAddress: currentTrip.pickupLocation ?? "",
            //                   pickupDateTime: currentTrip.pickupDate ?? "",
            //                   deliveryName: '',
            //                   deliveryAddress: currentTrip.deliveryLocation ?? "",
            //                   deliveryDateTime: currentTrip.deliveryDate ?? "",
            //                 );
            //               } else {
            //                 return SizedBox(); // Skip null values
            //               }
            //             },
            //           ),
            //         );
            //       } else {
            //         return Container(
            //           height: Get.height * 0.5,
            //           width: Get.width * 0.9,
            //           child: Center(
            //             child: Text('No data available'),
            //           ),
            //         );
            //       }
            //   }
            // }),



          ),


        ]),
      ),
    );
  }
}

// widget.status == 'started'
//     ? Positioned(
//         top: 60,
//         child:
//         LoadCards(
//           loadId: widget.loadId.toString(),
//           dateTime: widget.pickUpDateTime ?? "",
//           piece: widget.pieces.toString(),
//           dims: widget.dims??"",
//           weight: widget.weight??"",
//           miles: widget.miles??"",
//           pickupName: widget.pickupName?? "",
//           pickupAddress: widget.pickUpLocation??"",
//           pickupDateTime: widget.pickUpDateTime??"",
//           deliveryName: widget.deliveryName??"",
//           deliveryAddress: widget.deliveryAddress??"",
//           deliveryDateTime: widget.deliveryDateTime??"",
//         ),
// )
//     : SizedBox(),


// this.status = "no started",
// this.loadId = 0,
// this.pieces = 0,
// this.deliveryDateTime = '',
// this.dims = '',
// this.weight = '',
// this.pickupName = '',
// this.pickUpLocation = '',
// this.deliveryName = '',
// this.deliveryAddress = '',
// this.pickUpDateTime = '',
// this.miles = '',

// final int? loadId;
// final String? pickUpDateTime;
// final int? pieces;
// final String? dims;
// final String? weight;
// final String? pickupName;
// final String? miles;
// final String? pickUpLocation;
// final String? deliveryName;
// final String? deliveryAddress;
// final String? deliveryDateTime;
// final String? status;