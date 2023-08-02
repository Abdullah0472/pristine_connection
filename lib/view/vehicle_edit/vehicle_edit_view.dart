import 'package:celient_project/res/animation/FadeAnimation.dart';
import 'package:celient_project/res/assets/images.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_text_widget.dart';
import 'package:celient_project/view_model/controller/vehicle/vehicle_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class VehicleEditView extends StatelessWidget {
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String image6;
  final String image7;
  final String image8;
  final String image9;
  final String image10;
  final String image11;
  final String image12;
  final String vehicleType;
  final String weight;
  final String width;
  final String height;
  final String length;
  final String registerNumber;
  final String pallets;

  VehicleEditView(
      {Key? key,
      required this.image1,
      required this.image2,
      required this.image3,
      required this.image4,
      required this.image5,
      required this.image6,
      required this.image7,
      required this.image8,
      required this.image9,
      required this.image10,
      required this.image11,
      required this.image12,
      required this.vehicleType,
      required this.weight,
      required this.width,
      required this.height,
      required this.length,
      required this.registerNumber,
      required this.pallets})
      : super(key: key);

  final vehicleVM = Get.put(VehicleViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      appBar: CustomAppBar(
        icon: false,
        actionIcon: true,
        action: [],
        title: 'Vehicle Edit',
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
                FadeAnimation(
                  1.2,
                  Center(
                    child: InkWell(
                      onTap: () async {
                        Map<Permission, PermissionStatus> statuses = await [
                          Permission.storage,
                          Permission.camera,
                        ].request();

                        if (statuses[Permission.camera]!.isGranted) {
                          // ignore: use_build_context_synchronously
                          showBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return ShowBottom(
                                  // Select Image from
                                  containerIndex: 7,
                                  onImageSelected: (String? imageUrl) {
                                    if (imageUrl != null) {
                                      vehicleVM.image1Path =
                                          imageUrl as RxString;
                                    }
                                  }); // Pass the container index as 1 for the second container
                            },
                          );
                        } else {
                          print('No permission provided');
                          if (statuses[Permission.storage]!.isDenied ||
                              statuses[Permission.storage]!
                                  .isPermanentlyDenied) {
                            // Handle storage permission denied or permanently denied
                            print('Storage permission denied');
                          }
                          if (statuses[Permission.camera]!.isDenied ||
                              statuses[Permission.camera]!
                                  .isPermanentlyDenied) {
                            // Handle camera permission denied or permanently denied
                            print('Camera permission denied');
                          }
                        }
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: image1.isNotEmpty
                            ? NetworkImage(image1) as ImageProvider<Object>?
                            : const AssetImage(ImageAssets.lady),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                    1.4,
                    InputTextField(
                      initialValue: vehicleType ?? '',
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
                      initialValue: weight ?? '',
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
                    initialValue: width ?? '',
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
                    initialValue: height ?? '',
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
                    initialValue: length ?? '',
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
                    initialValue: registerNumber ?? '',
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
                    initialValue: pallets ?? '',
                    controller: vehicleVM.palletsController.value,
                    icons: MdiIcons.poundBox,
                    hintText: "Max Pallets",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: FadeAnimation(
                    2.6,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                color: Colors.lightBlue,
                                child: image1.isEmpty
                                    ? Icon(
                                        MdiIcons.cameraIris,
                                        color: AppColor.greyColor,
                                        size: 40,
                                      )
                                    : Image.network(image1)),
                            Container(
                                height: 100,
                                width: 100,
                                color: Colors.red,
                                child: image2.isEmpty
                                    ? Icon(
                                        MdiIcons.cameraIris,
                                        color: AppColor.greyColor,
                                        size: 40,
                                      )
                                    : Image.network(image2)),
                            Container(
                                height: 100,
                                width: 100,
                                color: Colors.yellow,
                                child: image3.isEmpty
                                    ? Icon(
                                        MdiIcons.cameraIris,
                                        color: AppColor.greyColor,
                                        size: 40,
                                      )
                                    : Image.network(image3)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                color: Colors.green,
                                child: image4.isEmpty
                                    ? Icon(
                                        MdiIcons.cameraIris,
                                        color: AppColor.greyColor,
                                        size: 40,
                                      )
                                    : Image.network(image4)),
                            Container(
                                height: 100,
                                width: 100,
                                color: Colors.brown,
                                child: image5.isEmpty
                                    ? Icon(
                                        MdiIcons.cameraIris,
                                        color: AppColor.greyColor,
                                        size: 40,
                                      )
                                    : Image.network(image5)),
                            Container(
                                height: 100,
                                width: 100,
                                color: Colors.purple,
                                child: image6.isEmpty
                                    ? Icon(
                                        MdiIcons.cameraIris,
                                        color: AppColor.greyColor,
                                        size: 40,
                                      )
                                    : Image.network(image6)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                color: Colors.lightBlue,
                                child: image7.isEmpty
                                    ? Icon(
                                        MdiIcons.cameraIris,
                                        color: AppColor.greyColor,
                                        size: 40,
                                      )
                                    : Image.network(image7)),
                            Container(
                                height: 100,
                                width: 100,
                                color: Colors.red,
                                child: image8.isEmpty
                                    ? Icon(
                                        MdiIcons.cameraIris,
                                        color: AppColor.greyColor,
                                        size: 40,
                                      )
                                    : Image.network(image8)),
                            Container(
                                height: 100,
                                width: 100,
                                color: Colors.yellow,
                                child: image9.isEmpty
                                    ? Icon(
                                        MdiIcons.cameraIris,
                                        color: AppColor.greyColor,
                                        size: 40,
                                      )
                                    : Image.network(image9)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
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
                    title: 'Update the Vehicle',
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
