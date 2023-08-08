import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/buttons/card_button.dart';
import 'package:celient_project/view/vehicle_edit/vehicle_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../assets/images.dart';

class VehicleCards extends StatelessWidget {
  final String vehicleType;
  final String vehicleModel;
  final String vehicleMake;
  final String vehicleYear;
  final String cargoDims;
  final String doorDims;
  String dockHigh;
  String liftGate;
  String tempCount;
  final String weight;
  final String width;
  final String height;
  final String length;
  final String registerNumber;
  final String registerNumberExp;
  String pallets;
  // final String registrationExpPic;
  RxString registrationExpPic = ''.obs;
  final String vehicleImage;

  VehicleCards({
    Key? key,
    required this.vehicleType,
    required this.length,
    required this.width,
    required this.height,
    required this.weight,
    required this.pallets,
    required this.vehicleModel,
    required this.vehicleMake,
    required this.vehicleYear,
    required this.cargoDims,
    required this.doorDims,
    required this.registerNumber,
    required this.registerNumberExp,
    required this.dockHigh,
    required this.liftGate,
    required this.tempCount,
    required this.registrationExpPic,
    required this.vehicleImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
      child: Container(
        // width: 300,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3.0,
              spreadRadius: 3.0,
              offset: const Offset(
                1.0,
                1.0,
              ),
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: AppColor.whiteColor,
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: vehicleImage != null && vehicleImage.isNotEmpty
                        ? NetworkImage(vehicleImage)
                        : Icon(MdiIcons.account) as ImageProvider,
                   // Add an empty container as a child
                  ),


                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        vehicleType,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Model: $vehicleModel",
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: AppColor.greyColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Make: $vehicleMake",
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: AppColor.greyColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Reg #: $registerNumber",
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: AppColor.greyColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Column(

                    children: [
                      CardButton(
                        title: 'Delete',
                        onPress: () {

                        },
                        buttonColor: AppColor.whiteColor,
                        textColor: AppColor.textColor,
                        width: 80,
                        height: 40,
                      ),
                      SizedBox(height: 10,),
                      CardButton(

                        title: 'Edit',
                        onPress: () {
                          Get.to(() => VehicleEditView(
                                vehicleType: vehicleType,
                                weight: weight,
                                width: width,
                                height: height,
                                length: length,
                                registerNumber: registerNumber,
                                pallets: pallets,
                                vehicleModel: vehicleModel,
                                vehicleMake: vehicleMake,
                                vehicleYear: vehicleYear,
                                cargoDims: cargoDims,
                                doorDims: doorDims,
                                dockHigh: dockHigh,
                                liftGate: liftGate,
                                tempCount: tempCount,
                                registerNumberExp: registerNumberExp,
                                registrationExpPic: registrationExpPic,
                              ));
                        },
                        buttonColor: AppColor.whiteColor,
                        textColor: AppColor.textColor,
                        width: 80,
                        height: 40,
                      ),
                    ],
                  )
                ],
              ),
              const Divider(
                color: AppColor.greyColor,
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
