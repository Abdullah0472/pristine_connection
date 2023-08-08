import 'dart:io';

import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/dropdown/dropDown.dart';
import 'package:celient_project/res/components/widgets/formfield/input_select_edit_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_text_widget.dart';
import 'package:celient_project/view_model/controller/vehicle/vehicle_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../res/components/widgets/bottom_sheet/bottom_sheet.dart';

// ignore: must_be_immutable
class VehicleEditView extends StatelessWidget {
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
  RxString registrationExpPic = ''.obs;

  VehicleEditView(
      {Key? key,
      required this.vehicleType,
      required this.weight,
      required this.width,
      required this.height,
      required this.length,
      required this.registerNumber,
      required this.pallets,
      required this.vehicleModel,
      required this.vehicleMake,
      required this.vehicleYear,
      required this.cargoDims,
      required this.doorDims,
      required this.dockHigh,
      required this.liftGate,
      required this.tempCount,
      required this.registerNumberExp, required this.registrationExpPic})
      : super(key: key);

  final vehicleVM = Get.put(VehicleViewModel());
  final accountdockey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: accountdockey,
      backgroundColor: AppColor.offWhite,
      appBar: const CustomAppBar(
        icon: false,
        actionIcon: true,
        action: [],
        title: 'Vehicle Edit',
        leadingIcon: SizedBox(),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(32, 132, 232, .3),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                                child: InputTextField(
                              initialValue: vehicleType,
                              controller:
                                  vehicleVM.vehicleTypeController.value,
                              icons: MdiIcons.truck,
                              hintText: "Vehicle Type",
                            )),
                            const VerticalDivider(
                              color: AppColor.greyColor,
                              thickness: 1,
                            ),
                            Expanded(
                              child: InputTextField(
                                initialValue: vehicleModel,
                                controller:
                                    vehicleVM.vehicleModelController.value,
                                hintText: 'Model',
                                icons: MdiIcons.truck,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: InputTextField(
                                initialValue: vehicleMake,
                                controller:
                                    vehicleVM.vehicleMakeController.value,
                                hintText: 'Make',
                                icons: MdiIcons.truck,
                              ),
                            ),
                            const VerticalDivider(
                              color: AppColor.greyColor,
                              thickness: 1,
                            ),
                            Expanded(
                              child: InputTextField(
                                number: false,
                                initialValue: vehicleYear,
                                controller:
                                    vehicleVM.vehicleYearController.value,
                                hintText: 'Year',
                                icons: MdiIcons.calendarBlank,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: InputTextField(
                                initialValue: height,
                                controller: vehicleVM.heightController.value,
                                hintText: 'Height',
                                icons: MdiIcons.arrowUpDown,
                              ),
                            ),
                            const VerticalDivider(
                              color: AppColor.greyColor,
                              thickness: 1,
                            ),
                            Expanded(
                              child: InputTextField(
                                number: false,
                                initialValue: length,
                                controller: vehicleVM.lengthController.value,
                                hintText: 'Length',
                                icons: MdiIcons.arrowLeftRight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: InputTextField(
                                initialValue: width,
                                controller: vehicleVM.widthController.value,
                                hintText: 'Width',
                                icons: MdiIcons.arrowLeftRight,
                              ),
                            ),
                            const VerticalDivider(
                              color: AppColor.greyColor,
                              thickness: 1,
                            ),
                            Expanded(
                              child: InputTextField(
                                number: false,
                                initialValue: weight,
                                controller: vehicleVM.weightController.value,
                                hintText: 'Weight',
                                icons: MdiIcons.weight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: InputTextField(
                                initialValue: cargoDims,
                                controller:
                                    vehicleVM.cargoDimsController.value,
                                hintText: 'Cargo Dims',
                                icons: MdiIcons.truckCargoContainer,
                              ),
                            ),
                            const VerticalDivider(
                              color: AppColor.greyColor,
                              thickness: 1,
                            ),
                            Expanded(
                              child: InputTextField(
                                number: false,
                                initialValue: doorDims,
                                controller:
                                    vehicleVM.doorDimsController.value,
                                hintText: 'Door Dims',
                                icons: MdiIcons.carDoor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      child: InputTextField(
                        hintText: "Registration Number",
                        initialValue: registerNumber,
                        controller:
                            vehicleVM.vehicleRegistrationController.value,
                        icons: MdiIcons.poundBox,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'PICTURE OF THE REGISTRATION EXP.',
                      style: TextStyle(
                        color: AppColor.infoTextColor,
                        fontWeight: FontWeight.w500,
                        // fontSize: 16,
                      ),
                    ),
                    Container(
                      width: Get.width,
                      height: 200,
                      color: AppColor.whiteColor,
                      child: Center(
                        child: Builder(
                          builder: (context) => IconButton(
                            onPressed: () async {
                              Map<Permission, PermissionStatus> statuses = await [
                                Permission.storage,
                                Permission.camera,
                              ].request();

                              if (statuses[Permission.camera]!.isGranted) {
                                SchedulerBinding.instance.addPostFrameCallback((_) {
                                  accountdockey.currentState!.showBottomSheet(
                                        (context) {
                                      return ShowBottom(
                                        containerIndex: 16,
                                        onImageSelected: (String? imageUrl) {
                                          if (imageUrl != null) {
                                            vehicleVM.regExpPic.value = imageUrl;
                                            registrationExpPic.value = imageUrl;
                                          }
                                        },
                                      );
                                    },
                                  );
                                });
                              } else {
                                print('No permission provided');
                                if (statuses[Permission.storage]!.isDenied ||
                                    statuses[Permission.storage]!.isPermanentlyDenied) {
                                  // Handle storage permission denied or permanently denied
                                  print('Storage permission denied');
                                }
                                if (statuses[Permission.camera]!.isDenied ||
                                    statuses[Permission.camera]!.isPermanentlyDenied) {
                                  // Handle camera permission denied or permanently denied
                                  print('Camera permission denied');
                                }
                              }
                            },
                            icon:
                            Obx(() {
                              if (registrationExpPic.value.isNotEmpty) {
                                if (registrationExpPic.value.startsWith('http')) {
                                  return Image.network(
                                    registrationExpPic.value,
                                    fit: BoxFit.fill,
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                  );
                                } else {
                                  return Image.file(
                                    File(registrationExpPic.value), // Local file path
                                    fit: BoxFit.fill,
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                  );
                                }
                              } else {
                                return const Icon(
                                  MdiIcons.cameraIris,
                                  size: 55,
                                  color: AppColor.blackColor,
                                );
                              }
                            }),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      child: InputDateEditSelectionTextField(
                        initialValue: registerNumberExp,
                        controller: vehicleVM.regExpController.value,
                        hintText: 'Registration Expiry',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                                child: DropDown(
                              hintSize: 12,
                              onSelected: (String? selectedValue) {
                                dockHigh = selectedValue!;
                                vehicleVM.dockHeightController.value.text =
                                    selectedValue;
                              },
                              dropDownController:
                                  vehicleVM.dockHeightController.value,
                              selectedItem: dockHigh,
                              hintText:
                                  'Dock High', // Set the initial value here
                            )
                            ),
                            const VerticalDivider(
                              color: AppColor.greyColor,
                              thickness: 1,
                            ),
                            Expanded(
                              child: DropDown(
                                hintSize: 12,
                                onSelected: (String? selectedValue) {
                                  pallets = selectedValue!;
                                  vehicleVM.palletJeckController.value.text =
                                      selectedValue;
                                },
                                dropDownController:
                                    vehicleVM.palletJeckController.value,
                                selectedItem: pallets,
                                hintText:
                                    'Pallet Jack', // Set the initial value here
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: DropDown(
                                hintSize: 12,
                                onSelected: (String? selectedValue) {
                                  liftGate = selectedValue!;
                                  vehicleVM.liftGateController.value.text =
                                      selectedValue;
                                },
                                dropDownController:
                                    vehicleVM.liftGateController.value,
                                selectedItem: liftGate,
                                hintText:
                                    'Lift Gate', // Set the initial value here
                              ),
                            ),
                            const VerticalDivider(
                              color: AppColor.greyColor,
                              thickness: 1,
                            ),
                            Expanded(
                              child: DropDown(
                                hintSize: 12,
                                onSelected: (String? selectedValue) {
                                  tempCount = selectedValue!;
                                  vehicleVM.tempCountController.value.text =
                                      selectedValue;
                                },
                                dropDownController:
                                    vehicleVM.tempCountController.value,
                                selectedItem: tempCount,
                                hintText:
                                    'Temp Count', // Set the initial value here
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              RoundButton(title: "Update Vehicle Details", onPress: (){},width: 250,),

            ],
          ),
        ),
      )),
    );
  }
}
