import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view/load_info/load_info_view.dart';
import 'package:celient_project/view_model/controller/button/button_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../colors/colors.dart';

class DialogeBoxConfirmation extends StatelessWidget {
  final String pickupAddress;
  final String piece;
  final String totalWeight;
  final ButtonController buttonController = Get.put(ButtonController());

  DialogeBoxConfirmation({
    Key? key,
    required this.pickupAddress, required this.piece,required this.totalWeight,

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
                const Text(
                  'Did you arrive to the Pick-up Address Below?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColor.blackColor,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  pickupAddress,
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
                          buttonController.buildUpdatedButton(() {
                            Get.to(() => LoadInfoView(piece: piece, totalWeight: totalWeight,));
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
