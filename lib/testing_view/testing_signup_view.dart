import 'dart:io';
import 'package:celient_project/res/animation/FadeAnimation.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:celient_project/res/components/widgets/buttons/radio_button/radio_button.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_date_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_email_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_password_widget.dart';
import 'package:celient_project/view_model/controller/loadDetail/loadDetail_view_model.dart';
import 'package:celient_project/view_model/controller/signup/signup_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class TestingSignUpView extends StatefulWidget {
  TestingSignUpView({Key? key}) : super(key: key);

  @override
  State<TestingSignUpView> createState() => _TestingSignUpViewState();
}

class _TestingSignUpViewState extends State<TestingSignUpView> {
  final signUpVM = Get.put(SignUpViewModel());

  final loadVM = Get.put(loadDetailViewModel());

  String title1 = "facemask";

  String title2 = "dock_high";

  String title3 = "pallet_jack";

  String title4 = "lift_gate";

  String title5 = "temp_count";

  String title6 = "hard_hat";

  String title7 = "steel_toe";

  String title8 = "vest";
  String title9 = "team";



  final accountdockey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> personalformkey = GlobalKey<FormState>();

  GlobalKey<FormState> singnUpformkey = GlobalKey<FormState>();

  GlobalKey<FormState> vehicleformkey = GlobalKey<FormState>();

  GlobalKey<FormState> insuarnceformkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: accountdockey,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xff618a2e),
              Color(0xff82bc3c),
              Color(0xff9fe34c),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    1.3,
                    const Text(
                      "Provide your Details ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Obx(() => Theme(
                      data: Theme.of(context).copyWith(
                          canvasColor: Colors.white,
                          colorScheme: const ColorScheme.light(
                              primary: AppColor.applicationColor)),
                      child: Stepper(
                        type: StepperType.horizontal,
                        steps: buildStep(),
                        currentStep: signUpVM.currentStep.value,
                        onStepContinue: () {
                          if (signUpVM.currentStep.value ==
                              buildStep().length - 1) {
                            print("Send data to server");
                          } else {
                            signUpVM.currentStep.value++;
                          }
                        },
                        onStepCancel: () {
                          signUpVM.currentStep.value == 0
                              ? null
                              : signUpVM.currentStep.value--;
                        },
                        onStepTapped: (index) {
                          signUpVM.currentStep.value = index;
                        },
                        controlsBuilder: (BuildContext context,
                            ControlsDetails controlsDetails) {
                          return Row(
                            children: [
                              Expanded(
                                child: RoundButton(
                                    title: signUpVM.currentStep.value ==
                                            buildStep().length - 1
                                        ? "SIGN UP"
                                        : "NEXT",
                                    onPress: signUpVM.currentStep.value ==
                                            buildStep().length - 1
                                        ? () {
                                            if (singnUpformkey.currentState!
                                                .validate()) {
                                              signUpVM.signUpApi();
                                              // signUpVM.emailController.value
                                              //     .clear();
                                              // signUpVM.passwordController.value
                                              //     .clear();
                                              // signUpVM.nameController.value
                                              //     .clear();
                                              // signUpVM.phoneController.value
                                              //     .clear();
                                            }
                                          }
                                        : () {
                                            if (personalformkey.currentState!
                                                .validate()) {
                                              controlsDetails
                                                  .onStepContinue!(); // fix here
                                            }
                                          }),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              if (signUpVM.currentStep.value != 0)
                                Expanded(
                                    child: RoundButton(
                                        title: "PREVIOUS",
                                        onPress: () {
                                          if (vehicleformkey.currentState!
                                              .validate()) {
                                            controlsDetails.onStepCancel!();
                                          }
                                        })),
                            ],
                          );
                        },
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Step> buildStep() {
    return [
      // Personal Information
      Step(
          title: Icon(
            MdiIcons.account,
            size: 30,
          ),
          content: Form(
            key: personalformkey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.4,
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
                              child: InputEmailTextField(
                                validator: signUpVM.validateEmail,
                                controller: signUpVM.nameController.value,
                                hintText: 'Name',
                                icons: const Icon(MdiIcons.accountCircle),
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
                              child: InputEmailTextField(
                                validator: signUpVM.validateEmail,
                                controller: signUpVM.emailController.value,
                                icons: const Icon(MdiIcons.email),
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
                              child: InputEmailTextField(
                                number: false,
                                hintText: 'Phone Number',
                                validator: signUpVM.validateEmail,
                                controller: signUpVM.phoneController.value,
                                icons: const Icon(MdiIcons.phone),
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
                              child: InputPasswordTextField(
                                isPasswordType: true,
                                icons: const Icon(MdiIcons.lock),
                                controllerpass:
                                    signUpVM.passwordController.value,
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
                              child: InputEmailTextField(
                                number: false,
                                hintText: 'Licence Number',
                                validator: signUpVM.validateEmail,
                                controller:
                                    signUpVM.licenceNumberController.value,
                                icons: const Icon(MdiIcons.license),
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
                              child: InputDateSelectionTextField(
                                controller:
                                    signUpVM.licenceExpireController.value,
                                hintText: 'Licence Expiry',
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Face Mask',
                                        style: TextStyle(
                                            color: AppColor.greyColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                    MyRadioButtons(
                                      onSelected: (String? selectedValue) {
                                        // title1 = selectedValue!;
                                        title1 = selectedValue ?? "facemask";
                                        signUpVM.faceMaskController.value.text =
                                            selectedValue!;
                                      },
                                      radioController:
                                          signUpVM.faceMaskController.value,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          isActive: signUpVM.currentStep.value >= 0,
          state: signUpVM.currentStep.value > 0
              ? StepState.complete
              : StepState.indexed),
      // Vehicle Information
      Step(

          title: Icon(
            MdiIcons.truck,
            size: 30,
          ),
          content: Form(
            key: vehicleformkey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.4,
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
                                      child: InputEmailTextField(
                                        validator: signUpVM.validateEmail,
                                        controller: signUpVM
                                            .vehicleTypeController.value,
                                        hintText: 'Type',
                                        icons: const Icon(MdiIcons.truck),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: AppColor.greyColor,
                                      thickness: 1,
                                    ),
                                    Expanded(
                                      child: InputEmailTextField(
                                        iconDisplay: false,
                                        validator: signUpVM.validateEmail,
                                        controller: signUpVM
                                            .vehicleModelController.value,
                                        hintText: 'Model',
                                        icons: const Icon(MdiIcons.truck),
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
                                      child: InputEmailTextField(
                                        validator: signUpVM.validateEmail,
                                        controller: signUpVM
                                            .vehicleMakeController.value,
                                        hintText: 'Make',
                                        icons: const Icon(MdiIcons.truck),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: AppColor.greyColor,
                                      thickness: 1,
                                    ),
                                    Expanded(
                                      child: InputEmailTextField(
                                        number: false,
                                        validator: signUpVM.validateEmail,
                                        controller: signUpVM
                                            .vehicleYearController.value,
                                        hintText: 'Year',
                                        icons:
                                            const Icon(MdiIcons.calendarBlank),
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
                                      child: InputEmailTextField(
                                        validator: signUpVM.validateEmail,
                                        controller:
                                            signUpVM.heightController.value,
                                        hintText: 'Height',
                                        icons: const Icon(MdiIcons.arrowUpDown),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: AppColor.greyColor,
                                      thickness: 1,
                                    ),
                                    Expanded(
                                      child: InputEmailTextField(
                                        number: false,
                                        validator: signUpVM.validateEmail,
                                        controller:
                                            signUpVM.lengthController.value,
                                        hintText: 'Length',
                                        icons:
                                            const Icon(MdiIcons.arrowLeftRight),
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
                                      child: InputEmailTextField(
                                        validator: signUpVM.validateEmail,
                                        controller:
                                            signUpVM.widthController.value,
                                        hintText: 'Width',
                                        icons:
                                            const Icon(MdiIcons.arrowLeftRight),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: AppColor.greyColor,
                                      thickness: 1,
                                    ),
                                    Expanded(
                                      child: InputEmailTextField(
                                        number: false,
                                        validator: signUpVM.validateEmail,
                                        controller:
                                            signUpVM.weightController.value,
                                        hintText: 'Weight',
                                        icons: const Icon(MdiIcons.weight),
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
                                      child: InputEmailTextField(
                                        validator: signUpVM.validateEmail,
                                        controller:
                                            signUpVM.cargoDimsController.value,
                                        hintText: 'Cargo Dims',
                                        icons: const Icon(
                                            MdiIcons.truckCargoContainer),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: AppColor.greyColor,
                                      thickness: 1,
                                    ),
                                    Expanded(
                                      child: InputEmailTextField(
                                        number: false,
                                        validator: signUpVM.validateEmail,
                                        controller:
                                            signUpVM.doorDimsController.value,
                                        hintText: 'Door Dims',
                                        icons: const Icon(MdiIcons.carDoor),
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
                              child: InputEmailTextField(
                                hintText: "Registration Number",
                                validator: signUpVM.validateEmail,
                                controller: signUpVM
                                    .vehicleRegistrationController.value,
                                icons: const Icon(MdiIcons.poundBox),
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
                                child: IconButton(
                                  onPressed: () async {
                                    Map<Permission, PermissionStatus> statuses =
                                    await [
                                      Permission.storage,
                                      Permission.camera,
                                    ].request();

                                    if (statuses[Permission.camera]!.isGranted) {
                                      SchedulerBinding.instance
                                          .addPostFrameCallback((_) {
                                        accountdockey.currentState!
                                            .showBottomSheet(
                                              (context) {
                                            return ShowBottom(
                                                containerIndex: 10,
                                                onImageSelected:
                                                    (String? imageUrl) {
                                                  if (imageUrl != null) {
                                                    signUpVM.regExpPic.value =
                                                        imageUrl;
                                                  }
                                                }); // Pass the container index as 0 for the first container
                                          },
                                        );
                                      });
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
                                  icon: Obx(() {
                                    if (loadVM.imageFiles[10].value.path != '') {
                                      // Use the imageFile list with index 1 for the second container
                                      return Image.file(
                                        loadVM.imageFiles[10].value,
                                        fit: BoxFit.fill,
                                        width: Get.width,
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
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                              child: InputDateSelectionTextField(
                                controller:
                                signUpVM.regExpController.value,
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Dock High',
                                        style: TextStyle(
                                            color: AppColor.greyColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                    MyRadioButtons(
                                      onSelected: (String? selectedValue) {
                                        // title2 = selectedValue!;
                                        title2 = selectedValue ?? "dock_high";
                                        signUpVM.dockHeightController.value
                                            .text = selectedValue!;
                                      },
                                      radioController:
                                          signUpVM.dockHeightController.value,
                                    ),
                                  ],
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Pallet Jack',
                                        style: TextStyle(
                                            color: AppColor.greyColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                    MyRadioButtons(
                                      onSelected: (String? selectedValue) {
                                        // title3 = selectedValue!;
                                        title3 = selectedValue ?? "pallet_jack";
                                        signUpVM.palletJeckController.value
                                            .text = selectedValue!;
                                      },
                                      radioController:
                                          signUpVM.palletJeckController.value,
                                    ),
                                  ],
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Lift Gate ',
                                        style: TextStyle(
                                            color: AppColor.greyColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                    MyRadioButtons(
                                      onSelected: (String? selectedValue) {
                                        // title4 = selectedValue!;
                                        title4 = selectedValue ?? "lift_gate";
                                        signUpVM.liftGateController.value.text =
                                            selectedValue!;
                                      },
                                      radioController:
                                          signUpVM.liftGateController.value,
                                    ),
                                  ],
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Temp Count',
                                        style: TextStyle(
                                            color: AppColor.greyColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                    MyRadioButtons(
                                      onSelected: (String? selectedValue) {
                                        // title5 = selectedValue!;
                                        title5 = selectedValue ?? "temp_count";
                                        signUpVM.tempCountController.value
                                            .text = selectedValue!;
                                      },
                                      radioController:
                                          signUpVM.tempCountController.value,
                                    ),
                                  ],
                                )),
                            Container(
                              height: 200,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                              child: signUpVM.selectedImages
                                      .isEmpty // If no images is selected
                                  ? const Center(
                                      child: Text('Sorry nothing selected!!'))
                                  // If atleast 1 images is selected
                                  : Obx(() {
                                      return GridView.builder(
                                        itemCount:
                                            signUpVM.selectedImages.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          // crossAxisSpacing: 5.0,
                                          // mainAxisSpacing: 5.0,
                                        ),
                                        itemBuilder: (BuildContext context,
                                            int index) {
                                          // Asset asset = signUpVM.images[index];
                                          return Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: kIsWeb
                                                    ? Image.network(signUpVM
                                                        .selectedImages[index]
                                                        .path)
                                                    : Image.file(signUpVM
                                                            .selectedImages[
                                                        index])),
                                          );
                                        },
                                      );
                                    }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundButton(
                        height: 40,
                        width: 150,
                        title: "Select Image",
                        onPress: () {
                          signUpVM.getImages();
                        }),
                  ],
                ),
              ),
            ),
          ),
          isActive: signUpVM.currentStep.value >= 1,
          state: signUpVM.currentStep.value > 1
              ? StepState.complete
              : StepState.indexed),
      // Account Information
      Step(
        title: Icon(
          MdiIcons.bankCircle,
          size: 30,
        ),
        content: Form(
          key: singnUpformkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                    1.4,
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
                            child: InputEmailTextField(
                              validator: signUpVM.validateEmail,
                              controller: signUpVM.bankNameController.value,
                              hintText: 'Bank Name',
                              icons: const Icon(MdiIcons.bank),
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
                            child: InputEmailTextField(
                              hintText: 'Account Name',
                              validator: signUpVM.validateEmail,
                              controller: signUpVM.accountNameController.value,
                              icons: const Icon(MdiIcons.account),
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
                            child: InputEmailTextField(
                              number: false,
                              hintText: 'Routing',
                              validator: signUpVM.validateEmail,
                              controller: signUpVM.routingController.value,
                              icons: const Icon(MdiIcons.counter),
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
                            child: InputEmailTextField(
                              number: false,
                              hintText: 'Account Number',
                              validator: signUpVM.validateEmail,
                              controller:
                                  signUpVM.accountNumberController.value,
                              icons: const Icon(MdiIcons.accountBox),
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
                              child: IconButton(
                                onPressed: () async {
                                  Map<Permission, PermissionStatus> statuses =
                                      await [
                                    Permission.storage,
                                    Permission.camera,
                                  ].request();

                                  if (statuses[Permission.camera]!.isGranted) {
                                    SchedulerBinding.instance
                                        .addPostFrameCallback((_) {
                                      accountdockey.currentState!
                                          .showBottomSheet(
                                        (context) {
                                          return ShowBottom(
                                              containerIndex: 8,
                                              onImageSelected:
                                                  (String? imageUrl) {
                                                if (imageUrl != null) {
                                                  signUpVM.accountDocPic.value =
                                                      imageUrl;
                                                }
                                              }); // Pass the container index as 0 for the first container
                                        },
                                      );
                                    });
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
                                icon: Obx(() {
                                  if (loadVM.imageFiles[8].value.path != '') {
                                    // Use the imageFile list with index 1 for the second container
                                    return Image.file(
                                      loadVM.imageFiles[8].value,
                                      fit: BoxFit.fill,
                                      width: Get.width,
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        isActive: signUpVM.currentStep.value >= 2,
        //======//
        state: signUpVM.currentStep.value > 2
            ? StepState.complete
            : StepState.indexed
      ),
      // Insurance Information
      Step(

          title: Icon(
            MdiIcons.shield,
            size: 30,
          ),
          content: Form(
            key: insuarnceformkey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.4,
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
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Hard Hat',
                                        style: TextStyle(
                                            color: AppColor.greyColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                    MyRadioButtons(
                                      onSelected: (String? selectedValue) {
                                        title6 = selectedValue ?? "hard_hat";
                                        signUpVM.hardHatController.value
                                            .text = selectedValue!;
                                      },
                                      radioController:
                                      signUpVM.hardHatController.value,
                                    ),
                                  ],
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
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Steel Toe',
                                        style: TextStyle(
                                            color: AppColor.greyColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                    MyRadioButtons(
                                      onSelected: (String? selectedValue) {
                                        title7= selectedValue ?? "steel_toe";
                                        signUpVM.steelToeController.value
                                            .text = selectedValue!;
                                      },
                                      radioController:
                                      signUpVM.steelToeController.value,
                                    ),
                                  ],
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
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Vest',
                                        style: TextStyle(
                                            color: AppColor.greyColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                    MyRadioButtons(
                                      onSelected: (String? selectedValue) {
                                        title8 = selectedValue ?? "vest";
                                        signUpVM.vestController.value
                                            .text = selectedValue!;
                                      },
                                      radioController:
                                      signUpVM.vestController.value,
                                    ),
                                  ],
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
                                child: IconButton(
                                  onPressed: () async {
                                    Map<Permission, PermissionStatus> statuses =
                                    await [
                                      Permission.storage,
                                      Permission.camera,
                                    ].request();

                                    if (statuses[Permission.camera]!.isGranted) {
                                      SchedulerBinding.instance
                                          .addPostFrameCallback((_) {
                                        accountdockey.currentState!
                                            .showBottomSheet(
                                              (context) {
                                            return ShowBottom(
                                                containerIndex: 9,
                                                onImageSelected:
                                                    (String? imageUrl) {
                                                  if (imageUrl != null) {
                                                    signUpVM.insuranceExpPic.value =
                                                        imageUrl;
                                                  }
                                                }); // Pass the container index as 0 for the first container
                                          },
                                        );
                                      });
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
                                  icon: Obx(() {
                                    if (loadVM.imageFiles[9].value.path != '') {
                                      // Use the imageFile list with index 1 for the second container
                                      return Image.file(
                                        loadVM.imageFiles[9].value,
                                        fit: BoxFit.fill,
                                        width: Get.width,
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
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                              child: InputDateSelectionTextField(
                                controller:
                                signUpVM.insuranceExpController.value,
                                hintText: 'Insurance Expiry',
                              ),

                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          isActive: signUpVM.currentStep.value >= 3,
          //======//
          state: signUpVM.currentStep.value > 3
              ? StepState.complete
              : StepState.indexed
      ),
      // Team Information
      Step(
          title: Icon(
            MdiIcons.accountGroup,
            size: 30,
          ),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                    1.4,
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
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text('Team',
                                      style: TextStyle(
                                          color: AppColor.greyColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400)),
                                  MyRadioButtons(
                                    onSelected: (String? selectedValue) {
                                      title9 = selectedValue ?? "team";
                                      signUpVM.teamController.value
                                          .text = selectedValue!;
                                    },
                                    radioController:
                                    signUpVM.teamController.value,
                                  ),
                                ],
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
                            child: InputEmailTextField(
                              hintText: "Team Name",
                              validator: signUpVM.validateEmail,
                              controller: signUpVM
                                  .teamNameController.value,
                              icons: const Icon(MdiIcons.accountMultiple),
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
                            child: InputEmailTextField(
                              number: false,
                              hintText: "Team Number",
                              validator: signUpVM.validateEmail,
                              controller: signUpVM
                                  .teamNumberController.value,
                              icons: const Icon(MdiIcons.accountMultiple),
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
                              child: IconButton(
                                onPressed: () async {
                                  Map<Permission, PermissionStatus> statuses =
                                  await [
                                    Permission.storage,
                                    Permission.camera,
                                  ].request();

                                  if (statuses[Permission.camera]!.isGranted) {
                                    SchedulerBinding.instance
                                        .addPostFrameCallback((_) {
                                      accountdockey.currentState!
                                          .showBottomSheet(
                                            (context) {
                                          return ShowBottom(
                                              containerIndex: 11,
                                              onImageSelected:
                                                  (String? imageUrl) {
                                                if (imageUrl != null) {
                                                  signUpVM.dlExpPic.value =
                                                      imageUrl;
                                                }
                                              }); // Pass the container index as 0 for the first container
                                        },
                                      );
                                    });
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
                                icon: Obx(() {
                                  if (loadVM.imageFiles[11].value.path != '') {
                                    // Use the imageFile list with index 1 for the second container
                                    return Image.file(
                                      loadVM.imageFiles[11].value,
                                      fit: BoxFit.fill,
                                      width: Get.width,
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
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ),
                            child: InputDateSelectionTextField(
                              controller:
                              signUpVM.dlExpController.value,
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
                              child: IconButton(
                                onPressed: () async {
                                  Map<Permission, PermissionStatus> statuses =
                                  await [
                                    Permission.storage,
                                    Permission.camera,
                                  ].request();

                                  if (statuses[Permission.camera]!.isGranted) {
                                    SchedulerBinding.instance
                                        .addPostFrameCallback((_) {
                                      accountdockey.currentState!
                                          .showBottomSheet(
                                            (context) {
                                          return ShowBottom(
                                              containerIndex: 12,
                                              onImageSelected:
                                                  (String? imageUrl) {
                                                if (imageUrl != null) {
                                                  signUpVM.greenCardExpPic.value =
                                                      imageUrl;
                                                }
                                              }); // Pass the container index as 0 for the first container
                                        },
                                      );
                                    });
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
                                icon: Obx(() {
                                  if (loadVM.imageFiles[12].value.path != '') {
                                    // Use the imageFile list with index 1 for the second container
                                    return Image.file(
                                      loadVM.imageFiles[12].value,
                                      fit: BoxFit.fill,
                                      width: Get.width,
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
                              child: IconButton(
                                onPressed: () async {
                                  Map<Permission, PermissionStatus> statuses =
                                  await [
                                    Permission.storage,
                                    Permission.camera,
                                  ].request();

                                  if (statuses[Permission.camera]!.isGranted) {
                                    SchedulerBinding.instance
                                        .addPostFrameCallback((_) {
                                      accountdockey.currentState!
                                          .showBottomSheet(
                                            (context) {
                                          return ShowBottom(
                                              containerIndex: 13,
                                              onImageSelected:
                                                  (String? imageUrl) {
                                                if (imageUrl != null) {
                                                  signUpVM.twicCardExpPic.value =
                                                      imageUrl;
                                                }
                                              }); // Pass the container index as 0 for the first container
                                        },
                                      );
                                    });
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
                                icon: Obx(() {
                                  if (loadVM.imageFiles[13].value.path != '') {
                                    // Use the imageFile list with index 1 for the second container
                                    return Image.file(
                                      loadVM.imageFiles[13].value,
                                      fit: BoxFit.fill,
                                      width: Get.width,
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
                              child: IconButton(
                                onPressed: () async {
                                  Map<Permission, PermissionStatus> statuses =
                                  await [
                                    Permission.storage,
                                    Permission.camera,
                                  ].request();

                                  if (statuses[Permission.camera]!.isGranted) {
                                    SchedulerBinding.instance
                                        .addPostFrameCallback((_) {
                                      accountdockey.currentState!
                                          .showBottomSheet(
                                            (context) {
                                          return ShowBottom(
                                              containerIndex: 14,
                                              onImageSelected:
                                                  (String? imageUrl) {
                                                if (imageUrl != null) {
                                                  signUpVM.tsaCardExpPic.value =
                                                      imageUrl;
                                                }
                                              }); // Pass the container index as 0 for the first container
                                        },
                                      );
                                    });
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
                                icon: Obx(() {
                                  if (loadVM.imageFiles[14].value.path != '') {
                                    // Use the imageFile list with index 1 for the second container
                                    return Image.file(
                                      loadVM.imageFiles[14].value,
                                      fit: BoxFit.fill,
                                      width: Get.width,
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
                              child: IconButton(
                                onPressed: () async {
                                  Map<Permission, PermissionStatus> statuses =
                                  await [
                                    Permission.storage,
                                    Permission.camera,
                                  ].request();

                                  if (statuses[Permission.camera]!.isGranted) {
                                    SchedulerBinding.instance
                                        .addPostFrameCallback((_) {
                                      accountdockey.currentState!
                                          .showBottomSheet(
                                            (context) {
                                          return ShowBottom(
                                              containerIndex: 15,
                                              onImageSelected:
                                                  (String? imageUrl) {
                                                if (imageUrl != null) {
                                                  signUpVM.hazmatExpPic.value =
                                                      imageUrl;
                                                }
                                              }); // Pass the container index as 0 for the first container
                                        },
                                      );
                                    });
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
                                icon: Obx(() {
                                  if (loadVM.imageFiles[15].value.path != '') {
                                    // Use the imageFile list with index 1 for the second container
                                    return Image.file(
                                      loadVM.imageFiles[15].value,
                                      fit: BoxFit.fill,
                                      width: Get.width,
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
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ),
                            child: InputDateSelectionTextField(
                              controller:
                              signUpVM.hazmatExpController.value,
                              hintText: 'Hazmat Expiry',
                            ),

                          ),


                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          isActive: signUpVM.currentStep.value >= 4,
          //======//
          // state: signUpVM.currentStep.value > 4
          //     ? StepState.complete
          //     : StepState.indexed
      ),

    ];
  }
}
