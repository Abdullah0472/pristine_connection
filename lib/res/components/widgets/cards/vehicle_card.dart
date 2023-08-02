import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/buttons/card_button.dart';
import 'package:celient_project/view/load_detail_tabBar/load_detail_tabBar_view.dart';
import 'package:celient_project/view/vehicle_edit/vehicle_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../assets/images.dart';

class VehicleCards extends StatelessWidget {
  final String vehicleType;
  final String length;
  final String width;
  final String height;
  final String weight;
  final String registrationNumber;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String pallets;

  const VehicleCards({
    Key? key,
    required this.vehicleType,
    required this.length,
    required this.width,
    required this.height,
    required this.weight,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.registrationNumber, required this.pallets,
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
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                    backgroundImage:
                        AssetImage(image1.isEmpty ? ImageAssets.lady : image1),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "$vehicleType",
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Reg #: $registrationNumber",
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: AppColor.greyColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Weight: $weight kg",
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: AppColor.greyColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "$length x $height x $width",
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: AppColor.greyColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  CardButton(
                    title: 'Edit',
                    onPress: () {
                      Get.to(() => VehicleEditView(
                          image1: image1,
                          image2: image2,
                          image3: image3,
                          image4: image4,
                          image5: "",
                          image6: "",
                          image7: "",
                          image8: "",
                          image9: '',
                          image10: '',
                          image11: '',
                          image12: '',
                          vehicleType: vehicleType,
                          weight: weight,
                          width: width,
                          height: height,
                          length: length,
                          registerNumber: registrationNumber, pallets: pallets,));
                    },
                    buttonColor: AppColor.whiteColor,
                    textColor: AppColor.textColor,
                    width: 80,
                    height: 40,
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
