
import 'dart:typed_data';
import 'package:celient_project/res/animation/FadeAnimation.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_text_widget.dart';

import 'package:celient_project/view_model/controller/signup/signup_view_model.dart';
import 'package:celient_project/view_model/controller/vehicle/vehicle_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:permission_handler/permission_handler.dart';

class AddVehicleView extends StatelessWidget {
  AddVehicleView({
    Key? key,
  }) : super(key: key);

  final vehicleVM = Get.put(VehicleViewModel());
  final signUpVM = Get.put(SignUpViewModel());

  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      appBar: CustomAppBar(
        icon: false,
        actionIcon: true,
        action: [],
        title: 'Add Vehicle',
        leadingIcon: const SizedBox(),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 55),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // FadeAnimation(
                //   1.2,
                //   Center(
                //     child: InkWell(
                //         onTap:  () async {
                //           Map<Permission, PermissionStatus> statuses = await [
                //             Permission.storage,
                //             Permission.camera,
                //           ].request();
                //           if (statuses[Permission.camera]!.isGranted) {
                //             SchedulerBinding.instance.addPostFrameCallback((_) {
                //               scaffoldKey.currentState!.showBottomSheet((context) {
                //                 return ShowBottom(
                //                     containerIndex: 8,
                //                     onImageSelected: (String? imageUrl) {
                //                       if (imageUrl != null) {
                //                         vehicleVM.image1Path.value = imageUrl;
                //                       }
                //                     }
                //                 ); // Pass the container index as 0 for the first container
                //               },
                //               );
                //             });
                //           } else {
                //             print('No permission provided');
                //             if (statuses[Permission.storage]!.isDenied ||
                //                 statuses[Permission.storage]!.isPermanentlyDenied) {
                //               // Handle storage permission denied or permanently denied
                //               print('Storage permission denied');
                //             }
                //             if (statuses[Permission.camera]!.isDenied ||
                //                 statuses[Permission.camera]!.isPermanentlyDenied) {
                //               // Handle camera permission denied or permanently denied
                //               print('Camera permission denied');
                //             }
                //           }
                //         },
                //         child: Container(
                //           height: 100,
                //           width: 150,
                //           color: Colors.brown,
                //         )),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                FadeAnimation(
                    1.4,
                    InputTextField(
                      initialValue: '',
                      controller: vehicleVM.vehicleTypeController.value,
                      icons: MdiIcons.truckFlatbed,
                      hintText: "Vehicle Type",
                    )),
                const SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                    1.6,
                    InputTextField(
                      initialValue: '',
                      controller: vehicleVM.weightController.value,
                      icons: MdiIcons.weight,
                      hintText: "Weight",
                    )),
                const SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  1.8,
                  InputTextField(
                    initialValue: '',
                    number: true,
                    controller: vehicleVM.widthController.value,
                    icons: MdiIcons.arrowLeftRight,
                    hintText: "Width",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  2,
                  InputTextField(
                    initialValue: '',
                    controller: vehicleVM.heightController.value,
                    icons: MdiIcons.arrowLeft,
                    hintText: "Height",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  2.2,
                  InputTextField(
                    initialValue: '',
                    controller: vehicleVM.lengthController.value,
                    icons: MdiIcons.arrowLeftRight,
                    hintText: "Length",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  2.4,
                  InputTextField(
                    initialValue: '',
                    controller: vehicleVM.registrationNumberController.value,
                    icons: MdiIcons.poundBox,
                    hintText: "Registration Number",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  2.6,
                  InputTextField(
                    initialValue: '',
                    controller: vehicleVM.palletsController.value,
                    icons: MdiIcons.poundBox,
                    hintText: "Max Pallets",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),


                SizedBox(height: 30,),
                FadeAnimation(
                  3.2,
                  RoundButton(
                    loading: false,
                    width: 300,
                    height: Get.height * 0.06,
                    onPress: () {
                      // Update the profile
                      // profileVM.updateUserApi();

                      // // Get the avatar image path
                      // final image1 =
                      //     vehicleVM.image1Path.value;
                      // // Get the licence image path
                      // final licencePath =
                      //     profileVM.licencePath.value;
                      //
                      // // Update the images
                      // profileVM.updateImageApi(avatarPath, licencePath);
                    },
                    title: 'Add Vehicle',
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
