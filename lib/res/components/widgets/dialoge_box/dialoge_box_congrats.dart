import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view/unloaded/unloaded_view.dart';
import 'package:celient_project/view_model/controller/button/button_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../colors/colors.dart';

class DialogeBoxCongrats extends StatelessWidget {
  DialogeBoxCongrats({
    Key? key,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Congratulations",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColor.blackColor,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "You Just Completed Unloading",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColor.greyColor,
                  ),
                ),
                RoundButton(
                  title: 'Got it',
                  textColor: AppColor.textColor,
                  buttonColor: AppColor.offWhite,
                  width: 100,
                  onPress: () {
                    Utils.snackBar("Status Changed", "Successfully");
                    Get.close(3);

                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
