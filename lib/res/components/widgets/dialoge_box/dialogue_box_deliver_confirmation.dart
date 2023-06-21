import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view/unloaded/unloaded_view.dart';
import 'package:celient_project/view_model/controller/button/button_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../colors/colors.dart';

class DialogeBoxDeliveryConfirmation extends StatelessWidget {
  final String deliverAddress;
  final String title;
  final String piece;
  final String totalWeight;
  final ButtonController buttonController = Get.put(ButtonController());

  DialogeBoxDeliveryConfirmation({
    Key? key,
    required this.deliverAddress, required this.piece,required this.totalWeight,
    required this.title,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: AppColor.whiteColor,
      child: contentBox(context),
    );

  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColor.offWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColor.blackColor,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  deliverAddress,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColor.greyColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: RoundButton(
                          textColor: AppColor.textColor,
                          title: "No",
                          onPress: () {},
                          buttonColor: AppColor.offWhite,
                          width: 50),
                    ),
                    Expanded(
                      child: RoundButton(
                        title: 'Yes',
                        textColor: AppColor.textColor,
                        buttonColor: AppColor.offWhite,
                        width: 50,
                        onPress: () {
                          Utils.snackBar("Status Changed", "Successfully");
                          buttonController.buildUnloadButton(() {
                                 // Get.toNamed(RouteName.unloadedView);
                            Get.to(()=> Scaffold(body: UnloadedView()));
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
