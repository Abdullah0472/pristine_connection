import 'dart:io';

import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_text_widget.dart';
import 'package:celient_project/view_model/controller/bankAccount_view_model/bankAccount_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class BankAccountView extends StatelessWidget {
  final String? bankName;
  final String accountName;
  final String routing;
  final String accountNumber;
  RxString bankAccountPic = ''.obs;

  BankAccountView({Key? key,
    required this.bankName,
    required this.accountName,
    required this.routing,
    required this.accountNumber,
    required this.bankAccountPic})
      : super(key: key);
  final bankVM = Get.put(BankAccountViewModel());
  final accountdockey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: accountdockey,
      appBar: const CustomAppBar(
        icon: false,
        actionIcon: true,
        action: [],
        title: 'Bank Account Edit',
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
                          child: InputTextField(
                            initialValue: bankName!,
                            controller: bankVM.bankNameController.value,
                            hintText: 'Bank Name',
                            icons: MdiIcons.bank,
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
                            initialValue: accountName,
                            hintText: 'Account Name',
                            controller: bankVM.accountNameController.value,
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
                            number: false,
                            hintText: 'Routing',
                            initialValue: routing,
                            controller: bankVM.routingController.value,
                            icons: MdiIcons.counter,
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
                            number: false,
                            hintText: 'Account Number',
                            initialValue: accountNumber,
                            controller: bankVM.accountNumberController.value,
                            icons: MdiIcons.accountBox,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'PICTURE OF THE BANK DOCUMENT',
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
                                            containerIndex: 20,
                                            onImageSelected: (String? imageUrl) {
                                              if (imageUrl != null) {
                                                bankVM.bankAccountPicPath.value = imageUrl;
                                                bankAccountPic.value = imageUrl;
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
                                  if (bankAccountPic.value.isNotEmpty) {
                                    if (bankAccountPic.value.startsWith('http')) {
                                      return Image.network(
                                        bankAccountPic.value,
                                        fit: BoxFit.fill,
                                        width: MediaQuery.of(context).size.width,
                                        height: 200,
                                      );
                                    } else {
                                      return Image.file(
                                        File(bankAccountPic.value), // Local file path
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


                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RoundButton(
                    title: "Update Bank Account",
                    onPress: () {

                      bankVM.updateBankAccountApi();
                    },
                    width: 250,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//   Image.file(
//     File(bankAccountPic.value), // Replace with the actual file path
//     fit: BoxFit.fill,
//     width: MediaQuery.of(context).size.width,
//     height: 200,
//   );