import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/dialoge_box/job_bid_dialogue.dart';
import 'package:celient_project/res/components/widgets/text/expanded_text.dart';
import 'package:celient_project/view/detail/detail_view.dart';
import 'package:celient_project/view_model/controller/all_jobs/all_jobs_view_model.dart';
import 'package:celient_project/view_model/controller/card/card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AllJobCards extends StatelessWidget {
  final String pickUpdate;
  final String pickUpday;
  final String pickUpmonth;
  final String loadId;
  final RxString price;
  final String pickupAddress;
  final String deliverAddress;
  final String dimension;
  final String weight;
  final String distance;
  final String type;
  final String piece;
  final String stackable;
  final String hazardous;
  final String dockLevel;
  final String deliveryDay;
  final String deliveryDate;
  final String deliveryYear;
  final String note;
  final CardController _cardController = Get.put(CardController());
  AllJobCards({
    Key? key,
    required this.pickUpdate,
    required this.pickUpday,
    required this.pickUpmonth,
    required this.loadId,
    required this.price,
    required this.pickupAddress,
    required this.deliverAddress,
    required this.weight,
    required this.distance,
    required this.type,
    required this.piece,
    required this.deliveryDay,
    required this.deliveryDate,
    required this.deliveryYear,
    required this.dimension,
    required this.stackable,
    required this.hazardous,
    required this.dockLevel,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allJobVM = Get.put(AllJobViewModel());
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.transparent,
          height: 340,
          child: Stack(
            children: [
              Container(
                height: 320,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 3.0,
                      spreadRadius: 3.0,
                      offset: const Offset(
                        1.0,
                        1.0,
                      ),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: AppColor.whiteColor,
                ),
                child: Visibility(
                  visible: _cardController.isExpanded.value,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 110,
                          height: 320,
                          decoration: const BoxDecoration(
                            color: AppColor.blueColorShade800,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  pickUpdate,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.whiteColor,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  pickUpday,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.whiteColor,
                                    fontSize: 20,
                                  ),
                                ),
                                const Divider(
                                  thickness: 4,
                                  color: AppColor.whiteColor,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  pickUpmonth,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.whiteColor,
                                    fontSize: 20,
                                  ),
                                ),
                                const Divider(
                                  thickness: 4,
                                  color: AppColor.whiteColor,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      loadId as String,
                                      style: const TextStyle(
                                        color: AppColor.appBarColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 100,
                                    ),

                                    // Container(
                                    //   width: 90,
                                    //   height: 30,
                                    //   decoration: const BoxDecoration(
                                    //       borderRadius: BorderRadius.all(
                                    //           Radius.circular(20)),
                                    //       color: AppColor.blueColorShade800),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.center,
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.center,
                                    //     children: [
                                    //       const Icon(
                                    //         MdiIcons.currencyUsd,
                                    //         size: 25,
                                    //         color: AppColor.whiteColor,
                                    //       ),
                                    //       // Text(
                                    //       //   price.value,
                                    //       //   style: const TextStyle(
                                    //       //     color: AppColor.whiteColor,
                                    //       //     fontWeight: FontWeight.w500,
                                    //       //     fontSize: 20,
                                    //       //   ),
                                    //       // ),
                                    //      Text(
                                    //         allJobVM.bidController.value.text,
                                    //         style: const TextStyle(
                                    //           color: AppColor.whiteColor,
                                    //           fontWeight: FontWeight.w500,
                                    //           fontSize: 20,
                                    //         ),
                                    //       )
                                    //
                                    //
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const Text(
                                  'Pick-up point',
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.greyColor,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.6, // Change this value as needed
                                  child: ExpandableText(
                                    text: pickupAddress,
                                    style: const TextStyle(
                                      color: AppColor.appBarColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Delivery Point',
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.greyColor,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  "$deliveryDay/$deliveryDate/$deliveryYear",
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.greyColor,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.6, // Change this value as needed
                                  child: ExpandableText(
                                    text: deliverAddress,
                                    style: const TextStyle(
                                      color: AppColor.appBarColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Note',
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.greyColor,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.6, // Change this value as needed
                                  child: ExpandableText(
                                    text: note,
                                    style: const TextStyle(
                                      color: AppColor.appBarColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      infoColumn("Weight", weight),
                                      const VerticalDivider(
                                        color: AppColor.greyColor,
                                      ),
                                      infoColumn("Loaded Miles", distance),
                                      const VerticalDivider(
                                        color: AppColor.greyColor,
                                      ),
                                      infoColumn("Pieces", piece),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      infoColumn("Stackable", stackable),
                                      const VerticalDivider(
                                        color: AppColor.greyColor,
                                      ),
                                      infoColumn("Hazardous", hazardous),
                                      const VerticalDivider(
                                        color: AppColor.greyColor,
                                      ),
                                      infoColumn("Dock Level", dockLevel),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      infoColumn("Vehicle Type", type),
                                      const VerticalDivider(
                                        color: AppColor.greyColor,
                                      ),
                                      infoColumn("Dims", dimension),
                                    ],
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
              Positioned(
                bottom: 2,
                right: 15,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return JobBidDialogBox(
                          vehicleType: type,
                          comment: note,
                          loadId: loadId,
                          jobVM: AllJobViewModel(),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 90,
                    height: 30,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: AppColor.blueColorShade800),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          MdiIcons.cursorDefaultClickOutline,
                          size: 25,
                          color: AppColor.whiteColor,
                        ),
                        Text(
                          'Bid',
                          style: TextStyle(
                            color: AppColor.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget infoColumn(String title, String data) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColor.appBarColor,
        ),
      ),
      Text(
        data,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: AppColor.infoTextColor,
        ),
      ),
    ],
  );
}
