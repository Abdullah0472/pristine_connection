import 'dart:io';

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
import 'package:celient_project/view_model/controller/loadDetail/loadDetail_view_model.dart';
import 'package:celient_project/view_model/controller/profile/profile_view_model.dart';
import 'package:celient_project/view_model/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final homeController = Get.put(ProfileViewModel());
  final loadVM = Get.put(loadDetailViewModel());
  UserPreference userPreference = UserPreference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.userListApi();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> profileformkey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      appBar: CustomAppBar(
        icon: true,
        actionIcon: true,
        action: [
          IconButton(
              onPressed: () {
            Get.toNamed(RouteName.updatePasswordView);
              },
              icon: const Icon(
                MdiIcons.lockReset,
                color: AppColor.blackColor,
                size: 25,
              )),
          IconButton(
              onPressed: () {
                userPreference.removeUser();
                Get.back();
                Get.back();
              },
              icon: const Icon(
                MdiIcons.logout,
                color: AppColor.blackColor,
                size: 25,
              )),
        ],
        title: 'User Profile',
        leadingIcon: const SizedBox(),
      ),
      body: SafeArea(
        child: Obx(() {
          switch (homeController.rxRequestStatus.value) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              if (homeController.error.value == 'No internet') {
                return InterNetExceptionWidget(
                  onPress: () {
                    homeController.refreshApi();
                  },
                );
              } else {
                return GeneralExceptionWidget(onPress: () {
                  homeController.refreshApi();
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
                                          // onImageSelected: (String? imageUrl) {
                                          //   // Update the image URL
                                          //   setState(() {
                                          //     homeController.userList.value.data?.avatar = imageUrl;
                                          //   });
                                          // },
                                          onImageSelected: (String? imageUrl) {
                                            if (imageUrl != null) {
                                              // If the container index is 5, it's an avatar image

                                              homeController.avatarPath.value = imageUrl;
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
                                backgroundImage: homeController
                                                .userList.value.data?.avatar !=
                                            null &&
                                        homeController.userList.value.data!
                                            .avatar!.isNotEmpty
                                    ? NetworkImage(homeController
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
                                  homeController.userList.value.data?.email ??
                                      '',
                              controller: homeController.emailController.value,
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
                                  homeController.userList.value.data?.name ??
                                      '',
                              controller: homeController.nameController.value,
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
                                homeController.userList.value.data?.phone ?? '',
                            number: true,
                            controller: homeController.phoneNumberController.value,
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
                                homeController.userList.value.data?.city ?? '',
                            controller: homeController.cityController.value,
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
                                homeController.userList.value.data?.state ?? '',
                            controller: homeController.stateController.value,
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
                                homeController.userList.value.data?.address ??
                                    '',
                            controller: homeController.addressController.value,
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
                                homeController.userList.value.data?.zip ?? '',
                            controller: homeController.zipController.value,
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
                                homeController.userList.value.data?.regNo ?? '',
                            controller: homeController.regNumberController.value,
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
                                                homeController.licencePath
                                                    .value = imageUrl;
                                              }
                                            });
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
                                  if (homeController
                                              .userList.value.data?.license !=
                                          null &&
                                      homeController.userList.value.data!
                                          .license!.isNotEmpty) {
                                    return Image.network(
                                      homeController
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
                              homeController.updateUserApi();

                              // Get the avatar image path
                              final avatarPath =
                                  homeController.avatarPath.value;
                              // Get the licence image path
                              final licencePath =
                                  homeController.licencePath.value;

                              // Update the images
                              homeController.updateImageApi(avatarPath, licencePath);
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
