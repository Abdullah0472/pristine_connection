import 'package:celient_project/res/animation/FadeAnimation.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_email_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_password_widget.dart';
import 'package:celient_project/view_model/controller/signup/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:multiple_images_picker/multiple_images_picker.dart';

class TestingSignUpView extends StatelessWidget {
  TestingSignUpView({Key? key}) : super(key: key);
  final signUpVM = Get.put(SignUpViewModel());
  GlobalKey<FormState> singnUpformkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Form(
                key: singnUpformkey,
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
                                              signUpVM.signUpApi();
                                              signUpVM.emailController.value
                                                  .clear();
                                              signUpVM.passwordController.value
                                                  .clear();
                                              signUpVM.nameController.value
                                                  .clear();
                                              signUpVM.phoneController.value
                                                  .clear();
                                            }
                                          : () {
                                              controlsDetails
                                                  .onStepContinue!(); // fix here
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
                                            controlsDetails
                                                .onStepCancel!(); // fix here
                                          })),
                              ],
                            );
                          },
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Step> buildStep() {
    return [
      Step(
          title: const Text(
            'Personal Info',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
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
                              controllerpass: signUpVM.passwordController.value,
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
          isActive: signUpVM.currentStep.value >= 0,
          state: signUpVM.currentStep.value > 0
              ? StepState.complete
              : StepState.indexed),
      Step(
        title: const Text(
          'Vehicle Info',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
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
                          child: InputEmailTextField(
                            validator: signUpVM.validateEmail,
                            controller: signUpVM.vehicleTypeController.value,
                            hintText: 'Truck Type',
                            icons: const Icon(MdiIcons.truckFlatbed),
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
                            controller:
                                signUpVM.vehicleRegistrationController.value,
                            icons: const Icon(MdiIcons.poundBox),
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
                            hintText: 'Weight',
                            validator: signUpVM.validateEmail,
                            controller: signUpVM.weightController.value,
                            icons: const Icon(MdiIcons.weight),
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
                            hintText: 'l x w x h',
                            validator: signUpVM.validateEmail,
                            controller: signUpVM.lengthController.value,
                            icons: const Icon(MdiIcons.arrowLeftRight),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Map<Permission, PermissionStatus> statuses = await [
                              Permission.storage,
                              Permission.camera,
                              Permission.photos,
                            ].request();
                            if (statuses[Permission.camera]!.isGranted &&
                                statuses[Permission.storage]!.isGranted &&
                                statuses[Permission.photos]!.isGranted) {
                              signUpVM.loadAssets();
                            } else {
                              print('No permission provided');
                              if (statuses[Permission.storage]!.isDenied ||
                                  statuses[Permission.storage]!.isPermanentlyDenied) {
                                print('Storage permission denied');
                                PermissionStatus storageStatus = await Permission.storage.request();
                                if (storageStatus.isDenied || storageStatus.isPermanentlyDenied) {
                                  print('Storage permission still denied after re-request');
                                  // openAppSettings();
                                }
                              }
                              if (statuses[Permission.camera]!.isDenied ||
                                  statuses[Permission.camera]!.isPermanentlyDenied) {
                                // Handle camera permission denied or permanently denied
                                print('Camera permission denied');
                                PermissionStatus cameraStatus = await Permission.camera.request();
                                if (cameraStatus.isDenied || cameraStatus.isPermanentlyDenied) {
                                  print('Camera permission still denied after re-request');
                                  openAppSettings();
                                }
                              }
                            }
                          },
                          child: Container(
                            height: 200,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ),
                            child: Obx(() {
                              return GridView.builder(
                                itemCount: signUpVM.images.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  Asset asset = signUpVM.images[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      child: AssetThumb(
                                        asset: asset,
                                        width: 300,
                                        height: 300,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
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
        isActive: signUpVM.currentStep.value >= 1,
      ),
    ];
  }
}
