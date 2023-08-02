import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/exception/general_exception.dart';
import 'package:celient_project/res/components/widgets/exception/internet_exceptions_widget.dart';
import 'package:celient_project/view/add_vehicle_view/add_vehicle_view.dart';
import 'package:celient_project/view_model/controller/profile/profile_view_model.dart';
import 'package:celient_project/view_model/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/components/widgets/cards/vehicle_card.dart';

class VehicleView extends StatefulWidget {
  const VehicleView({Key? key}) : super(key: key);

  @override
  State<VehicleView> createState() => _VehicleViewState();
}

class _VehicleViewState extends State<VehicleView> {
  final profileVM = Get.put(ProfileViewModel());
  UserPreference userPreference = UserPreference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      body: SafeArea(
        child: Obx(() {
          switch (profileVM.rxRequestStatus.value) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              if (profileVM.error.value == 'No internet') {
                return InterNetExceptionWidget(
                  onPress: () {
                    profileVM.refreshApi();
                  },
                );
              } else {
                return GeneralExceptionWidget(onPress: () {
                  profileVM.refreshApi();
                });
              }
            case Status.COMPLETED:
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  RoundButton(
                    title: "Add More Vehicle",
                    onPress: () {

                      Get.to(() => AddVehicleView());
                    },
                    width: 250,
                    height: 30,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: ListView.builder(
                        itemCount: 15,
                        itemBuilder: (context, index) {
                          return VehicleCards(
                            pallets: '1000',
                            vehicleType: 'Vavo Truck SWT',
                            length: '85',
                            width: '85',
                            height: '85',
                            weight: '850',
                            image1: '',
                            image2: '',
                            image3: '',
                            image4: '',
                            registrationNumber: 'BJN-785',
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
          }
        }),
      ),
    );
  }
}
