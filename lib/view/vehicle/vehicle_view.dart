import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/res/animation/FadeAnimation.dart';
import 'package:celient_project/res/assets/images.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/exception/general_exception.dart';
import 'package:celient_project/res/components/widgets/exception/internet_exceptions_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_text_widget.dart';
import 'package:celient_project/res/routes/routes_name.dart';
import 'package:celient_project/view_model/controller/profile/profile_view_model.dart';
import 'package:celient_project/view_model/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VehicleView extends StatefulWidget {
  const VehicleView({Key? key}) : super(key: key);

  @override
  State<VehicleView> createState() => _VehicleViewState();
}

class _VehicleViewState extends State<VehicleView> {
  final profileVM = Get.put(ProfileViewModel());
  UserPreference userPreference = UserPreference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileVM.userListApi();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> profileformkey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      // appBar: CustomAppBar(
      //   icon: true,
      //   actionIcon: true,
      //   action: [
      //     IconButton(
      //         onPressed: () {
      //       Get.toNamed(RouteName.updatePasswordView);
      //         },
      //         icon: const Icon(
      //           MdiIcons.lockReset,
      //           color: AppColor.blackColor,
      //           size: 25,
      //         )),
      //     IconButton(
      //         onPressed: () {
      //           userPreference.removeUser();
      //           Get.back();
      //           Get.back();
      //         },
      //         icon: const Icon(
      //           MdiIcons.logout,
      //           color: AppColor.blackColor,
      //           size: 25,
      //         )),
      //   ],
      //   title: 'User Profile',
      //   leadingIcon: const SizedBox(),
      // ),
      body: SafeArea(
        child: Obx(() {
          switch (profileVM.rxRequestStatus.value) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              if (profileVM.error.value == 'No internet') {
                return InterNetExceptionWidget(
                  onPress: () {
                    profileVM.refreshApi();
                  },
                );
              } else {
                return GeneralExceptionWidget(onPress: () {
                  profileVM.refreshApi();
                });
              }
            case Status.COMPLETED:
              return Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 55),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: profileformkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FadeAnimation(
                          1.2,
                          Center(
                            child: InkWell(
                              onTap: () async {
                                Map<Permission, PermissionStatus> statuses =
                                await [
                                  Permission.storage,
                                  Permission.camera,
                                ].request();

                                if (statuses[Permission.camera]!.isGranted) {
                                  // ignore: use_build_context_synchronously
                                  showBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ShowBottom(
                                          containerIndex: 5,
                                          onImageSelected: (String? imageUrl) {
                                            if (imageUrl != null) {
                                              profileVM.avatarPath.value = imageUrl;
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
                                backgroundImage: profileVM
                                    .userList.value.data?.avatar !=
                                    null &&
                                    profileVM.userList.value.data!
                                        .avatar!.isNotEmpty
                                    ? NetworkImage(profileVM
                                    .userList
                                    .value
                                    .data!
                                    .avatar!) as ImageProvider<Object>?
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
                              initialValue:
                              profileVM.userList.value.data?.email ??
                                  '',
                              controller: profileVM.emailController.value,
                              icons: MdiIcons.emailOutline,
                              hintText: "Email",
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.6,
                            InputTextField(
                              initialValue:
                              profileVM.userList.value.data?.name ??
                                  '',
                              controller: profileVM.nameController.value,
                              icons: MdiIcons.accountCircle,
                              hintText: "Name",
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          1.8,
                          InputTextField(
                            initialValue:
                            profileVM.userList.value.data?.phone ?? '',
                            number: true,
                            controller: profileVM.phoneNumberController.value,
                            icons: MdiIcons.phoneOutline,
                            hintText: "Phone Number",
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          2,
                          InputTextField(
                            initialValue:
                            profileVM.userList.value.data?.city ?? '',
                            controller: profileVM.cityController.value,
                            icons: MdiIcons.city,
                            hintText: "City",
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          2.2,
                          InputTextField(
                            initialValue:
                            profileVM.userList.value.data?.state ?? '',
                            controller: profileVM.stateController.value,
                            icons: MdiIcons.homeGroup,
                            hintText: "State",
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          2.4,
                          InputTextField(
                            initialValue:
                            profileVM.userList.value.data?.address ??
                                '',
                            controller: profileVM.addressController.value,
                            icons: MdiIcons.mapMarker,
                            hintText: "Address",
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          2.6,
                          InputTextField(
                            number: true,
                            initialValue:
                            profileVM.userList.value.data?.zip ?? '',
                            controller: profileVM.zipController.value,
                            icons: MdiIcons.poundBox,
                            hintText: "Zip Code",
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          2.8,
                          InputTextField(
                            number: true,
                            initialValue:
                            profileVM.userList.value.data?.regNo ?? '',
                            controller: profileVM.regNumberController.value,
                            icons: MdiIcons.poundBox,
                            hintText: "Registration Number",
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          3,
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            color: AppColor.whiteColor,
                            child: Center(
                              child: IconButton(
                                onPressed: () async {
                                  Map<Permission, PermissionStatus> statuses =
                                  await [
                                    Permission.storage,
                                    Permission.camera,
                                  ].request();

                                  if (statuses[Permission.camera]!.isGranted) {
                                    // ignore: use_build_context_synchronously
                                    showBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ShowBottom(
                                            containerIndex: 6,
                                            onImageSelected:
                                                (String? imageUrl) {
                                              if (imageUrl != null) {
                                                profileVM.licencePath
                                                    .value = imageUrl;
                                              }
                                            }
                                        );
                                      },
                                    );
                                  } else {
                                    print('No permission provided');
                                    if (statuses[Permission.storage]!
                                        .isDenied ||
                                        statuses[Permission.storage]!
                                            .isPermanentlyDenied) {
                                      print('Storage permission denied');
                                    }
                                    if (statuses[Permission.camera]!.isDenied ||
                                        statuses[Permission.camera]!
                                            .isPermanentlyDenied) {
                                      print('Camera permission denied');
                                    }
                                  }
                                },
                                icon: Obx(() {
                                  if (profileVM
                                      .userList.value.data?.license !=
                                      null &&
                                      profileVM.userList.value.data!
                                          .license!.isNotEmpty) {
                                    return Image.network(
                                      profileVM
                                          .userList.value.data!.license!,
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
                        ),
                        const SizedBox(
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
                              profileVM.updateUserApi();

                              // Get the avatar image path
                              final avatarPath =
                                  profileVM.avatarPath.value;
                              // Get the licence image path
                              final licencePath =
                                  profileVM.licencePath.value;

                              // Update the images
                              profileVM.updateImageApi(avatarPath, licencePath);
                            },
                            title: 'Update the Profile',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
          }
        }),
      ),
    );
  }
}
