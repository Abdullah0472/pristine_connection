// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:celient_project/res/components/widgets/formfield/input_laod_info.dart';
import 'package:celient_project/view_model/controller/loadDetail/loadDetail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadInfoView extends StatelessWidget {
  final String piece;
  final String totalWeight;

  LoadInfoView({Key? key, required this.piece, required this.totalWeight})
      : super(key: key);
  final loadVM = Get.put(loadDetailViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      appBar: CustomAppBar(
        icon: false,
        actionIcon: false,
        action: Container(),
        title: 'Load Info',
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 60,
                  ),
                  Text(
                    'SCHEDULED',
                    style: TextStyle(
                        color: AppColor.infoTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'ACTUAL',
                    style: TextStyle(
                        color: AppColor.infoTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              color: AppColor.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
                            text: const TextSpan(
                                text: 'Pieces',
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.blackColor,
                                  fontSize: 19,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '  -x-x-in',
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.greyColor,
                                        fontSize: 16),
                                  )
                                ]),
                          ),
                          Center(
                            child: Text(
                              '  $piece',
                              style: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: AppColor.blackColor,
                                fontSize: 19,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: 130,
                              child: InputReviewTextField(
                                controller: loadVM.pieceController.value,
                                icons: MdiIcons.pound,
                                hintText: 'Piece',
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
                            text: const TextSpan(
                                text: 'Total Weight',
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.blackColor,
                                  fontSize: 19,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '  lb',
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.greyColor,
                                        fontSize: 16),
                                  )
                                ]),
                          ),
                          Center(
                            child: Text(
                              '$totalWeight',
                              style: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: AppColor.blackColor,
                                fontSize: 19,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: 130,
                              child: InputReviewTextField(
                                controller: loadVM.totalWeightController.value,
                                icons: MdiIcons.weight,
                                hintText: 'Weight',
                              ))
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColor.greyColor,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'INFORMATION ON THE BOL',
              style: TextStyle(
                  color: AppColor.infoTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              color: AppColor.whiteColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputReviewTextField(
                      controller: loadVM.bolNumberController.value,
                      icons: MdiIcons.poundBoxOutline,
                      hintText: 'BOL #',
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'PICTURE OF THE BOL',
              style: TextStyle(
                  color: AppColor.infoTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 15,
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 200,
            //   color: AppColor.whiteColor,
            //   child: Center(
            //     child: IconButton(
            //       onPressed: () async {
            //         // await loadVM.pickImage();
            //         Map<Permission, PermissionStatus> statuses = await [
            //           Permission.storage,
            //           Permission.camera,
            //         ].request();
            //         if (statuses[Permission.storage]!.isGranted &&
            //             statuses[Permission.camera]!.isGranted) {
            //           loadVM.showImagePicker(context);
            //         } else {
            //           print('no permission provided');
            //         }
            //       },
            //       icon: Obx(() {
            //         if (loadVM.imageFile != '') {
            //           return Image.file(loadVM.imageFile,fit: BoxFit.fill,);
            //
            //         } else {
            //           return Icon(
            //             MdiIcons.cameraIris,
            //             size: 55,
            //             color: AppColor.blackColor,
            //           );
            //         }
            //       }),
            //     ),
            //   ),
            // ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: AppColor.whiteColor,
              child: Center(
                child: IconButton(
                  onPressed: () async {
                    // await loadVM.pickImage();
                    Map<Permission, PermissionStatus> statuses = await [
                      Permission.storage,
                      Permission.camera,
                    ].request();
                    if (statuses[Permission.storage]!.isGranted &&
                        statuses[Permission.camera]!.isGranted) {
                      showBottomSheet( context: context,
                          builder: (BuildContext context){
                        return ShowBottom();
                          });
                    } else {
                      print('no permission provided');
                    }
                  },
                  icon: Obx(() {
                    if (loadVM.imageFile.value.path != '') {
                      return Image.file(loadVM.imageFile.value, fit: BoxFit.fill);
                    } else {
                      return Icon(
                        MdiIcons.cameraIris,
                        size: 55,
                        color: AppColor.blackColor,
                      );
                    }
                  }),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
