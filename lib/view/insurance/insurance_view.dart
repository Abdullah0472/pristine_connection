import 'dart:io';

import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/dropdown/dropDown.dart';
import 'package:celient_project/res/components/widgets/formfield/input_select_edit_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_text_widget.dart';
import 'package:celient_project/view_model/controller/bankAccount_view_model/bankAccount_view_model.dart';
import 'package:celient_project/view_model/insurance/insurance_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class InsuranceView extends StatelessWidget {
  String hardHat;
  String steelToe;
  String vest;
final String insuranceExp;

  RxString insurancePic = ''.obs;

  InsuranceView(
      {Key? key,
      required this.hardHat,
      required this.vest,
      required this.steelToe,
        required this.insurancePic, required this.insuranceExp
      })
      : super(key: key);
  final insuranceVM = Get.put(InsuranceViewModel());
  final insurancedockey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: insurancedockey,
      appBar: const CustomAppBar(
        icon: false,
        actionIcon: true,
        action: [],
        title: 'Insurance Edit',
        leadingIcon: SizedBox(),
      ),
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
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
                                    child: DropDown(
                                  hintSize: 12,
                                  onSelected: (String? selectedValue) {
                                    hardHat = selectedValue!;
                                    insuranceVM.hardHatController.value.text =
                                        selectedValue;
                                  },
                                  dropDownController:
                                      insuranceVM.hardHatController.value,
                                  selectedItem: hardHat,
                                  hintText:
                                      'Hard Hat', // Set the initial value here
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
                                      steelToe = selectedValue!;
                                      insuranceVM.steelToeController.value
                                          .text = selectedValue;
                                    },
                                    dropDownController:
                                        insuranceVM.steelToeController.value,
                                    selectedItem: steelToe,
                                    hintText:
                                        'Steel Toe', // Set the initial value here
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
                            child: DropDown(
                              hintSize: 12,
                              onSelected: (String? selectedValue) {
                                vest = selectedValue!;
                                insuranceVM.vestController.value.text =
                                    selectedValue;
                              },
                              dropDownController:
                                  insuranceVM.vestController.value,
                              selectedItem: vest,
                              hintText: 'Vest', // Set the initial value here
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'PICTURE OF THE INSURANCE EXP.',
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
                                      insurancedockey.currentState!.showBottomSheet(
                                            (context) {
                                          return ShowBottom(
                                            containerIndex: 21,
                                            onImageSelected: (String? imageUrl) {
                                              if (imageUrl != null) {
                                                insuranceVM.insurancePicPath.value = imageUrl;
                                                insurancePic.value = imageUrl;
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
                                  if (insurancePic.value.isNotEmpty) {
                                    if (insurancePic.value.startsWith('http')) {
                                      return Image.network(
                                        insurancePic.value,
                                        fit: BoxFit.fill,
                                        width: MediaQuery.of(context).size.width,
                                        height: 200,
                                      );
                                    } else {
                                      return Image.file(
                                        File(insurancePic.value), // Local file path
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
                            initialValue: insuranceExp,
                            controller: insuranceVM.insuranceExpController.value,
                            hintText: 'Insurance Expiry',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  RoundButton(title: "Update Insurance", onPress: (){},width: 250,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
