import 'dart:io';

import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/dropdown/dropDown.dart';
import 'package:celient_project/res/components/widgets/formfield/input_select_edit_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_text_widget.dart';
import 'package:celient_project/view_model/controller/bankAccount_view_model/bankAccount_view_model.dart';
import 'package:celient_project/view_model/controller/team/team_view_model.dart';
import 'package:celient_project/view_model/insurance/insurance_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class TeamView extends StatelessWidget {
  String team;
  final String teamName;
  final String teamNumber;
  RxString dlExpPic = ''.obs;
  final String dlExp;
  RxString greenCard = ''.obs;
  RxString twicCard = ''.obs;
  RxString tsaCard = ''.obs;
  RxString hazmat = ''.obs;
  final String hazmatExp;

  TeamView({
    Key? key,
    required this.team,
    required this.teamName,
    required this.teamNumber,
    required this.dlExpPic,
    required this.dlExp,
    required this.greenCard,
    required this.twicCard,
    required this.tsaCard,
    required this.hazmat,
    required this.hazmatExp,
  }) : super(key: key);
  final teamVM = Get.put(TeamViewModel());
  final teamKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: teamKey,
      appBar: const CustomAppBar(
        icon: false,
        actionIcon: true,
        action: [],
        title: 'Other Edit',
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
                            child: DropDown(
                              hintSize: 12,
                              onSelected: (String? selectedValue) {
                                team = selectedValue!;
                                teamVM.teamController.value.text =
                                    selectedValue;
                              },
                              dropDownController: teamVM.teamController.value,
                              selectedItem: team,
                              hintText: 'Team', // Set the initial value here
                            )),
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
                            initialValue: teamName,
                            hintText: 'Team Name',
                            controller: teamVM.teamNameController.value,
                            icons: MdiIcons.account,
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
                            initialValue: teamNumber,
                            hintText: 'Team Number',
                            controller: teamVM.teamNumberController.value,
                            icons: MdiIcons.account,
                          ),
                        ),
                        // -------- DL EXP ----- //
                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'PICTURE OF THE DL EXP.',
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
                                      teamKey.currentState!.showBottomSheet(
                                            (context) {
                                          return ShowBottom(
                                            containerIndex: 22,
                                            onImageSelected: (String? imageUrl) {
                                              if (imageUrl != null) {
                                                teamVM.dlExpPicPath.value = imageUrl;
                                                dlExpPic.value = imageUrl;
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
                                  if (dlExpPic.value.isNotEmpty) {
                                    if (dlExpPic.value.startsWith('http')) {
                                      return Image.network(
                                        dlExpPic.value,
                                        fit: BoxFit.fill,
                                        width: MediaQuery.of(context).size.width,
                                        height: 200,
                                      );
                                    } else {
                                      return Image.file(
                                        File(dlExpPic.value), // Local file path
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
                            initialValue: dlExp,
                            controller: teamVM.dlExpController.value,
                            hintText: 'DL Expiry',
                          ),
                        ),

                        //----- GREEN CARD  -----//

                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'PICTURE OF THE GREEN CARD',
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
                                      teamKey.currentState!.showBottomSheet(
                                            (context) {
                                          return ShowBottom(
                                            containerIndex: 23,
                                            onImageSelected: (String? imageUrl) {
                                              if (imageUrl != null) {
                                                teamVM.greenCardPicPath.value = imageUrl;
                                                greenCard.value = imageUrl;
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
                                  if (greenCard.value.isNotEmpty) {
                                    if (greenCard.value.startsWith('http')) {
                                      return Image.network(
                                        greenCard.value,
                                        fit: BoxFit.fill,
                                        width: MediaQuery.of(context).size.width,
                                        height: 200,
                                      );
                                    } else {
                                      return Image.file(
                                        File(greenCard.value), // Local file path
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

                        // ------ TWIC CARD ------ ///

                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'PICTURE OF THE TWIC CARD',
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
                                      teamKey.currentState!.showBottomSheet(
                                            (context) {
                                          return ShowBottom(
                                            containerIndex: 24,
                                            onImageSelected: (String? imageUrl) {
                                              if (imageUrl != null) {
                                                teamVM.twicCardPicPath.value = imageUrl;
                                                twicCard.value = imageUrl;
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
                                  if (twicCard.value.isNotEmpty) {
                                    if (twicCard.value.startsWith('http')) {
                                      return Image.network(
                                        twicCard.value,
                                        fit: BoxFit.fill,
                                        width: MediaQuery.of(context).size.width,
                                        height: 200,
                                      );
                                    } else {
                                      return Image.file(
                                        File(twicCard.value), // Local file path
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

                        // ------ TCA CARD ------//
                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'PICTURE OF THE TSA CARD',
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
                                      teamKey.currentState!.showBottomSheet(
                                            (context) {
                                          return ShowBottom(
                                            containerIndex: 25,
                                            onImageSelected: (String? imageUrl) {
                                              if (imageUrl != null) {
                                                teamVM.tsaCardPicPath.value = imageUrl;
                                                tsaCard.value = imageUrl;
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
                                  if (tsaCard.value.isNotEmpty) {
                                    if (tsaCard.value.startsWith('http')) {
                                      return Image.network(
                                        tsaCard.value,
                                        fit: BoxFit.fill,
                                        width: MediaQuery.of(context).size.width,
                                        height: 200,
                                      );
                                    } else {
                                      return Image.file(
                                        File(tsaCard.value), // Local file path
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

                        // -------- HAZMAT EXP ----- //
                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'PICTURE OF THE HAZMAT EXP.',
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
                                      teamKey.currentState!.showBottomSheet(
                                            (context) {
                                          return ShowBottom(
                                            containerIndex: 26,
                                            onImageSelected: (String? imageUrl) {
                                              if (imageUrl != null) {
                                                teamVM.hazmatExpPicPath.value = imageUrl;
                                                hazmat.value = imageUrl;
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
                                  if (hazmat.value.isNotEmpty) {
                                    if (hazmat.value.startsWith('http')) {
                                      return Image.network(
                                        hazmat.value,
                                        fit: BoxFit.fill,
                                        width: MediaQuery.of(context).size.width,
                                        height: 200,
                                      );
                                    } else {
                                      return Image.file(
                                        File(hazmat.value), // Local file path
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
                            initialValue: hazmatExp,
                            controller: teamVM.hazmatExpController.value,
                            hintText: 'Hazmat Expiry',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  RoundButton(title: "Update Other Details", onPress: (){},width: 250,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
