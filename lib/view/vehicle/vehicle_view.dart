import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/res/assets/images.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/exception/general_exception.dart';
import 'package:celient_project/res/components/widgets/exception/internet_exceptions_widget.dart';
import 'package:celient_project/view/add_vehicle_view/add_vehicle_view.dart';
import 'package:celient_project/view_model/controller/profile/profile_view_model.dart';
import 'package:celient_project/view_model/controller/user_preference/user_prefrence_view_model.dart';
import 'package:celient_project/view_model/controller/vehicle/vehicle_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../res/components/widgets/cards/vehicle_card.dart';

class VehicleView extends StatefulWidget {
  const VehicleView({Key? key}) : super(key: key);

  @override
  State<VehicleView> createState() => _VehicleViewState();
}

class _VehicleViewState extends State<VehicleView> {
  final vehicleVM = Get.put(VehicleViewModel());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vehicleVM.assignVehicleListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              //flex: 1,
              child: RoundButton(
                title: "Add More Vehicle",
                onPress: () {
                  Get.to(() => AddVehicleView());
                },
                width: 250,
                height: 30,
              ),
            ),
            Expanded(
              flex: 12,
              child: Obx(() {
                switch (vehicleVM.rxRequestStatus.value) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    if (vehicleVM.error.value == 'No internet') {
                      return InterNetExceptionWidget(
                        onPress: () {
                          vehicleVM.refreshApi();
                        },
                      );
                    } else {
                      return GeneralExceptionWidget(onPress: () {
                        vehicleVM.refreshApi();
                      });
                    }
                  case Status.COMPLETED:
                    return (vehicleVM.vehicleList.value.data!.isNotEmpty)
                        ? SmartRefresher(
                controller: vehicleVM.refreshAssignBidController,
                onRefresh: () async {
                await  vehicleVM.refreshApi();
                vehicleVM.refreshAssignBidController.refreshCompleted();
                },

                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: ListView.builder(
                                itemCount: vehicleVM.vehicleList.value.data!.length,
                                itemBuilder: (context, index) {
                                  String firstImageUrl = vehicleVM.vehicleList.value.data![index].images!.split(",")[0];
                                  return VehicleCards(
                                    vehicleModel: vehicleVM.vehicleList.value.data![index].model
                                        .toString(),
                                    pallets: vehicleVM.vehicleList.value.data![index].palletJack
                                        .toString(),
                                    vehicleType: vehicleVM.vehicleList.value.data![index].type
                                        .toString(),
                                    length: vehicleVM.vehicleList.value.data![index].length
                                        .toString(),
                                    width: vehicleVM.vehicleList.value.data![index].width
                                        .toString(),
                                    height: vehicleVM.vehicleList.value.data![index].height
                                        .toString(),
                                    weight: vehicleVM.vehicleList.value.data![index].weight
                                        .toString(),
                                    registerNumber: vehicleVM.vehicleList.value.data![index].regNo
                                        .toString(),
                                    vehicleMake: vehicleVM.vehicleList.value.data![index].vehicleMake
                                        .toString(),
                                    vehicleYear: vehicleVM.vehicleList.value.data![index].year
                                        .toString(),
                                    cargoDims: vehicleVM.vehicleList.value.data![index].cargoDims
                                        .toString(),
                                    doorDims: vehicleVM.vehicleList.value.data![index].doorDims
                                        .toString(),
                                    registerNumberExp: vehicleVM.vehicleList.value.data![index].regExpDate
                                        .toString(),
                                    dockHigh: vehicleVM.vehicleList.value.data![index].dockHigh
                                        .toString(),
                                    liftGate: vehicleVM.vehicleList.value.data![index].liftGate
                                        .toString(),
                                    tempCount: vehicleVM.vehicleList.value.data![index].tempCount
                                        .toString(),
                                    registrationExpPic: RxString(vehicleVM.vehicleList.value.data![index].regExp
                                        .toString()),
                                    vehicleImage: firstImageUrl ,
                                  );
                                },
                              ),
                          ),
                        )
                        : const Center(child: Text('No Vehicle Found'));
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
