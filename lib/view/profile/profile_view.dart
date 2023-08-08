import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/res/animation/FadeAnimation.dart';
import 'package:celient_project/res/assets/images.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/dropdown/dropDown.dart';
import 'package:celient_project/res/components/widgets/exception/general_exception.dart';
import 'package:celient_project/res/components/widgets/exception/internet_exceptions_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_select_edit_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_text_widget.dart';
import 'package:celient_project/view/bankAccount/bankAccount_view.dart';
import 'package:celient_project/view/insurance/insurance_view.dart';
import 'package:celient_project/view/team/team_view.dart';
import 'package:celient_project/view_model/controller/profile/profile_view_model.dart';
import 'package:celient_project/view_model/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final profileVM = Get.put(ProfileViewModel());

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
              return SmartRefresher(
                controller: profileVM.refreshProfileController,
                onRefresh: () async {
                  await profileVM.refreshApi();
                  profileVM.refreshProfileController.refreshCompleted();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: profileformkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.to(() => BankAccountView(
                                        bankName: profileVM.userList.value.data!
                                                .bankName ??
                                            "",
                                        accountName: profileVM.userList.value
                                                .data!.accountName ??
                                            "",
                                        routing: profileVM
                                                .userList.value.data!.routing ??
                                            "",
                                        accountNumber: profileVM.userList.value
                                                .data!.accountNumber ??
                                            "",
                                        bankAccountPic: RxString(profileVM
                                                .userList
                                                .value
                                                .data!
                                                .bankDocs ??
                                            "https://img.freepik.com/premium-vector/avatar-profile-icon_188544-4755.jpg"),
                                      ));
                                },
                                icon: Icon(
                                  MdiIcons.bankCircle,
                                  size: 30,
                                ),
                              ),

                              IconButton(
                                onPressed: () {
                                  Get.to(() => InsuranceView(
                                        hardHat: profileVM
                                                .userList.value.data!.hardHat ??
                                            "",
                                        vest: profileVM
                                                .userList.value.data!.vest ??
                                            "",
                                        steelToe: profileVM.userList.value.data!
                                                .steelToe ??
                                            "",
                                        insurancePic: RxString(profileVM
                                                .userList
                                                .value
                                                .data!
                                                .insuranceExp ??
                                            "https://img.freepik.com/premium-vector/avatar-profile-icon_188544-4755.jpg"),
                                        insuranceExp: profileVM.userList.value
                                                .data!.insExpDate ??
                                            "",
                                      ));
                                },
                                icon: Icon(
                                  MdiIcons.shield,
                                  size: 30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Get.to(() => TeamView(
                                      team: profileVM.userList.value.data!.team ??
                                          "",
                                      teamName: profileVM
                                              .userList.value.data!.teamName ??
                                          "",
                                      teamNumber: profileVM.userList.value.data!
                                              .teamNumber ??
                                          "",
                                      dlExpPic:
                                     RxString(profileVM.userList.value.data!.dlExp ??
                                              ""),
                                      dlExp: profileVM
                                              .userList.value.data!.dlExpDate ??
                                          "",
                                      greenCard: RxString(profileVM
                                              .userList.value.data!.greenCard ??
                                          ""),
                                      twicCard:
                                      RxString(profileVM.userList.value.data!.twicCard ??
                                              ""),
                                      tsaCard: RxString(profileVM.userList.value.data!.tsaCard ?? ""),
                                      hazmat: RxString(profileVM.userList.value.data!.hazmatExp ?? ""),
                                      hazmatExp: profileVM.userList.value.data!.hazmatExpDate ?? ""));
                                },
                                icon: Icon(
                                  MdiIcons.accountGroup,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
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
                                            onImageSelected:
                                                (String? imageUrl) {
                                              if (imageUrl != null) {
                                                profileVM.avatarPath.value =
                                                    imageUrl;
                                              }
                                            }); // Pass the container index as 1 for the second container
                                      },
                                    );
                                  } else {
                                    print('No permission provided');
                                    if (statuses[Permission.storage]!
                                            .isDenied ||
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
                                  backgroundImage: profileVM.userList.value.data
                                                  ?.avatar !=
                                              null &&
                                          profileVM.userList.value.data!.avatar!
                                              .isNotEmpty
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
                                    profileVM.userList.value.data?.email ?? '',
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
                                    profileVM.userList.value.data?.name ?? '',
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
                                  profileVM.userList.value.data?.address ?? '',
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
                                  profileVM.userList.value.data?.licenceNo ??
                                      '',
                              controller:
                                  profileVM.licenceNumberController.value,
                              icons: MdiIcons.license,
                              hintText: "Licence Number",
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            3.0,
                            InputDateEditSelectionTextField(
                              initialValue:
                                  profileVM.userList.value.data?.licenceExp ??
                                      '',
                              controller:
                                  profileVM.licenceExpNumberController.value,
                              hintText: 'Licence Expiry',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            3.2,
                            DropDown(
                              hintSize: 12,
                              onSelected: (String? selectedValue) {
                                profileVM.userList.value.data?.facemask =
                                    selectedValue!;
                                profileVM.faceMaskController.value.text =
                                    selectedValue!;
                              },
                              dropDownController:
                                  profileVM.faceMaskController.value,
                              selectedItem:
                                  profileVM.userList.value.data!.facemask!,
                              hintText:
                                  'Face Mask', // Set the initial value here
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: const Text(
                              'PICTURE OF THE LICENCE',
                              style: TextStyle(
                                color: AppColor.infoTextColor,
                                fontWeight: FontWeight.w500,
                                // fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          FadeAnimation(
                            3.4,
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

                                    if (statuses[Permission.camera]!
                                        .isGranted) {
                                      // ignore: use_build_context_synchronously
                                      showBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ShowBottom(
                                              containerIndex: 6,
                                              onImageSelected:
                                                  (String? imageUrl) {
                                                if (imageUrl != null) {
                                                  profileVM.licencePath.value =
                                                      imageUrl;
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
                                      if (statuses[Permission.camera]!
                                              .isDenied ||
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
                                        profileVM.userList.value.data!.license!
                                            .isNotEmpty) {
                                      return Image.network(
                                        profileVM.userList.value.data!.license!,
                                        fit: BoxFit.fill,
                                        width:
                                            MediaQuery.of(context).size.width,
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
                            3.6,
                            RoundButton(
                              loading: false,
                              width: 300,
                              height: Get.height * 0.06,
                              onPress: () {
                                // Update the profile
                                profileVM.updateUserApi();

                                // Get the avatar image path
                                final avatarPath = profileVM.avatarPath.value;
                                // Get the licence image path
                                final licencePath = profileVM.licencePath.value;

                                // Update the images
                                profileVM.updateImageApi(
                                    avatarPath, licencePath);
                              },
                              title: 'Update the Profile',
                            ),
                          ),
                        ],
                      ),
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
