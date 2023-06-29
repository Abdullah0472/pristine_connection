import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/formfield/input_job_filter.dart';
import 'package:celient_project/view_model/controller/all_jobs/all_jobs_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../buttons/round_button_widget.dart';

class JobBidDialogBox extends StatelessWidget {
  JobBidDialogBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: AppColor.offWhite,
      child: contentBox(context),
    );
  }

  final allJobVM = Get.put(AllJobViewModel());
  contentBox(context) {
    GlobalKey<FormState> geofenceformkey = GlobalKey<FormState>();
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColor.offWhite,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Form(
            key: geofenceformkey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Center(
                    child: Text(
                      "Your Offer",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        fontFamily: 'Merriweather',
                        color: AppColor.blueColorShade800,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade400, //color of divider
                    height: 3, //height spacing of divider
                    thickness: 2, //thickness of divier line
                    indent: 50, //spacing at the start of divider
                    endIndent: 50, //spacing at the end of divider
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputJobFilterTextField(
                          hint: "Bid",
                          controller: allJobVM.bidController.value,
                          // Set the initial value to the price
                          // validator: settingsVM.validateTextField,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: RoundButton(
                              buttonColor: AppColor.blueColorShade800,
                              title: "My Bid",
                              width: 150,
                              height: Get.height * 0.05,
                              onPress: () {
                                allJobVM.updatePrice(allJobVM.bidController.value.text);
                                Get.back();
                              }),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
