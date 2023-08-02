// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_laod_info.dart';
import 'package:celient_project/view_model/controller/button/button_view_model.dart';
import 'package:celient_project/view_model/controller/current_trip/current_trip_view_model.dart';
import 'package:celient_project/view_model/controller/loadDetail/loadDetail_view_model.dart';
import 'package:celient_project/view_model/controller/unloaded/unloaded_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signature/signature.dart';

class UnloadedView extends StatefulWidget {
  final String loadId;

  UnloadedView({
    Key? key,
    this.loadId = "",
  }) : super(key: key);

  @override
  State<UnloadedView> createState() => _UnloadedViewState();
}

class _UnloadedViewState extends State<UnloadedView> {
  final ButtonController buttonController = Get.put(ButtonController());
  final unloadVM = Get.put(UnloadDataViewModel());
  final loadVM = Get.put(loadDetailViewModel());
  final currentTripVM = Get.put(CurrentTripController());
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<SignatureState> signatureKey = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColor.offWhite,
      appBar: CustomAppBar(
        icon: false,
        actionIcon: false,
        action: [Container()],
        title: 'Unloading',
        leadingIcon: SizedBox(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                'RECEIVED BY',
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
                        keyboardType: true,
                        controller: unloadVM.receiveByController.value,
                        icons: MdiIcons.truckCargoContainer,
                        hintText: 'Received By',
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'SIGNATURE',
                style: TextStyle(
                  color: AppColor.infoTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(() {
                final signatureImagePath = unloadVM.signatureImagePath.value;
                if (signatureImagePath.isNotEmpty) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: AppColor.whiteColor,
                    child: Image.file(
                      File(signatureImagePath),
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        color: AppColor.whiteColor,
                        child: Center(
                          child: RepaintBoundary(
                            key: unloadVM
                                .imageKey, // Assign the signatureKey to the RepaintBoundary
                            child: Signature(
                              controller: unloadVM.signatureController,
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              backgroundColor: AppColor.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RoundButton(
                        loading: false,
                        width: 100,
                        height: Get.height * 0.04,
                        onPress: () async {
                          await unloadVM.captureSignature();
                        },
                        title: 'Capture',
                      ),
                    ],
                  );
                }
              }),

              const SizedBox(
                height: 15,
              ),
              const Text(
                'PICTURE OF THE PLACE OF UNLOADING',
                style: TextStyle(
                  color: AppColor.infoTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: AppColor.whiteColor,
                child: Center(
                  child: IconButton(
                    onPressed: () async {
                      Map<Permission, PermissionStatus> statuses = await [
                        Permission.storage,
                        Permission.camera,
                      ].request();

                      if (statuses[Permission.camera]!.isGranted) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          scaffoldKey.currentState!.showBottomSheet(
                            (context) {
                              return ShowBottom(
                                  containerIndex: 3,
                                  onImageSelected: (String? imageUrl) {
                                    if (imageUrl != null) {
                                      unloadVM.unloadPlacePath.value = imageUrl;
                                    }
                                  }); // Pass the container index as 0 for the first container
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
                    icon: Obx(() {
                      if (loadVM.imageFiles[3].value.path != '') {
                        // Use the imageFile list with index 1 for the second container
                        return Image.file(
                          loadVM.imageFiles[3].value,
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                        );
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
              const SizedBox(
                height: 40,
              ),
              RoundButton(
                loading: false,
                width: 300,
                height: Get.height * 0.06,
                onPress: () async {
                  final unloadPlacePath = unloadVM.unloadPlacePath.value;
                  unloadVM.uploadUnLoadApi(unloadPlacePath, widget.loadId);
                },
                title: 'Complete Shipment',
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
