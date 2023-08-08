import 'package:celient_project/res/animation/FadeAnimation.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:celient_project/res/components/widgets/buttons/radio_button/radio_button.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_date_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_text_widget.dart';
import 'package:celient_project/view_model/controller/loadDetail/loadDetail_view_model.dart';
import 'package:celient_project/view_model/controller/vehicle/vehicle_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class AddVehicleView extends StatelessWidget {
  AddVehicleView({
    Key? key,
  }) : super(key: key);

  final vehicleVM = Get.put(VehicleViewModel());

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final loadVM = Get.put(loadDetailViewModel());


  String title2 = "dock_high";

  String title3 = "pallet_jack";

  String title4 = "lift_gate";

  String title5 = "temp_count";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColor.offWhite,
      appBar: const CustomAppBar(
        icon: false,
        actionIcon: true,
        action: [],
        title: 'Add Vehicle',
        leadingIcon: SizedBox(),
      ),
      body: SafeArea(
          child:
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            child: Form(
              // key: vehicleformkey,
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
                                        child: InputTextField(
                                          controller: vehicleVM
                                              .vehicleTypeController.value,
                                          hintText: 'Type',
                                          icons: MdiIcons.truck,
                                        ),
                                      ),
                                      const VerticalDivider(
                                        color: AppColor.greyColor,
                                        thickness: 1,
                                      ),
                                      Expanded(
                                        child: InputTextField(

                                          controller: vehicleVM
                                              .vehicleModelController.value,
                                          hintText: 'Model',
                                          icons: MdiIcons.truck,
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
                                        child: InputTextField(

                                          controller: vehicleVM
                                              .vehicleMakeController.value,
                                          hintText: 'Make',
                                          icons: MdiIcons.truck,
                                        ),
                                      ),
                                      const VerticalDivider(
                                        color: AppColor.greyColor,
                                        thickness: 1,
                                      ),
                                      Expanded(
                                        child: InputTextField(
                                          number: false,

                                          controller: vehicleVM
                                              .vehicleYearController.value,
                                          hintText: 'Year',
                                          icons:
                                          MdiIcons.calendarBlank,
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
                                        child: InputTextField(

                                          controller:
                                          vehicleVM.heightController.value,
                                          hintText: 'Height',
                                          icons: MdiIcons.arrowUpDown,
                                        ),
                                      ),
                                      const VerticalDivider(
                                        color: AppColor.greyColor,
                                        thickness: 1,
                                      ),
                                      Expanded(
                                        child: InputTextField(
                                          number: false,

                                          controller:
                                          vehicleVM.lengthController.value,
                                          hintText: 'Length',
                                          icons: MdiIcons.arrowLeftRight,
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
                                        child: InputTextField(

                                          controller:
                                          vehicleVM.widthController.value,
                                          hintText: 'Width',
                                          icons: MdiIcons.arrowLeftRight,
                                        ),
                                      ),
                                      const VerticalDivider(
                                        color: AppColor.greyColor,
                                        thickness: 1,
                                      ),
                                      Expanded(
                                        child: InputTextField(
                                          number: false,

                                          controller:
                                          vehicleVM.weightController.value,
                                          hintText: 'Weight',
                                          icons: MdiIcons.weight,
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
                                        child: InputTextField(

                                          controller:
                                          vehicleVM.cargoDimsController.value,
                                          hintText: 'Cargo Dims',
                                          icons:
                                              MdiIcons.truckCargoContainer,
                                        ),
                                      ),
                                      const VerticalDivider(
                                        color: AppColor.greyColor,
                                        thickness: 1,
                                      ),
                                      Expanded(
                                        child: InputTextField(
                                          number: false,

                                          controller:
                                          vehicleVM.doorDimsController.value,
                                          hintText: 'Door Dims',
                                          icons: MdiIcons.carDoor,
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
                                child: InputTextField(
                                  hintText: "Registration Number",

                                  controller: vehicleVM
                                      .vehicleRegistrationController.value,
                                  icons: MdiIcons.poundBox,
                                ),
                              ),
                              const SizedBox(
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
                                          scaffoldKey.currentState!
                                              .showBottomSheet(
                                                (context) {
                                              return ShowBottom(
                                                  containerIndex: 18,
                                                  onImageSelected:
                                                      (String? imageUrl) {
                                                    if (imageUrl != null) {
                                                      vehicleVM.regExpPic.value = imageUrl;
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
                                      if (loadVM.imageFiles[18].value.path != '') {
                                        // Use the imageFile list with index 1 for the second container
                                        return Image.file(
                                          loadVM.imageFiles[18].value,
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
                                  vehicleVM.regExpController.value,
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
                                          vehicleVM.dockHeightController.value
                                              .text = selectedValue!;
                                        },
                                        radioController:
                                        vehicleVM.dockHeightController.value,
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
                                          vehicleVM.palletJeckController.value
                                              .text = selectedValue!;
                                        },
                                        radioController:
                                        vehicleVM.palletJeckController.value,
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
                                          vehicleVM.liftGateController.value.text =
                                          selectedValue!;
                                        },
                                        radioController:
                                        vehicleVM.liftGateController.value,
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
                                          vehicleVM.tempCountController.value
                                              .text = selectedValue!;
                                        },
                                        radioController:
                                        vehicleVM.tempCountController.value,
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
                                child: vehicleVM.selectedImages
                                    .isEmpty // If no images is selected
                                    ? const Center(
                                    child: Text('Sorry nothing selected!!'))
                                // If atleast 1 images is selected
                                    : Obx(() {
                                  return GridView.builder(
                                    itemCount:
                                    vehicleVM.selectedImages.length,
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      // crossAxisSpacing: 3.0,
                                      // mainAxisSpacing: 3.0,
                                    ),
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      // Asset asset = signUpVM.images[index];
                                      return Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: kIsWeb
                                                ? Image.network(vehicleVM
                                                .selectedImages[index]
                                                .path)
                                                : Image.file(vehicleVM
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
                            vehicleVM.getImages();
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      RoundButton(
                        loading: false,
                        width: 300,
                        height: Get.height * 0.06,
                        onPress: () {

                          vehicleVM.addVehicleApi();
                          Get.back();
                        },
                        title: 'Add Vehicle',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

      ),
    );
  }
}
