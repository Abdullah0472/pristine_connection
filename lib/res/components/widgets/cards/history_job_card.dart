import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/text/expanded_text.dart';
import 'package:celient_project/view/history_detail/history_detail_view.dart';
import 'package:celient_project/view_model/controller/card/card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HistoryJobCards extends StatelessWidget {
  final String date;
  final String day;
  final String month;
  final String orderNo;
  final String price;
  final String pickupAddress;
  final String pickupName;
  final String deliverName;
  final String deliverAddress;
  final String time;
  final String weight;
  final String distance;
  final String type;
  final String piece;
  final String deliverDate;
  final String deliverDay;
  final String deliverMonth;
  final String deliverTime;
  final String podImage;
  final String unloadingImage;
  final CardController _cardController = Get.put(CardController());
  HistoryJobCards({
    Key? key,
    required this.date,
    required this.day,
    required this.month,
    required this.orderNo,
    required this.price,
    required this.pickupAddress,
    required this.deliverAddress,
    required this.time,
    required this.weight,
    required this.distance,
    required this.type,
    required this.piece,
    required this.deliverDate,
    required this.deliverDay,
    required this.deliverMonth,
    required this.deliverTime, required this.pickupName, required this.deliverName, required this.podImage, required this.unloadingImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onDoubleTap: () {
            Get.to(() => HistoryDetailView(
                  pickupName: pickupName,
                  pickupAddress: pickupAddress,
                  pickupDateTime: time,
                  piece: piece,
                  dims: "",
                  weight: weight,
                  deliveryName: deliverName,
                  deliveryAddress: deliverAddress,
                  deliveryTime: deliverTime,
                  orderNo: orderNo,
                  price: price,
                  date: date,
                  day: day,
                  month: month,
                  deliverDate: deliverDate,
                  deliverDay: deliverDay,
                  deliverMonth: deliverMonth, podImage: podImage,unloadingImage: unloadingImage,
                ));
          },
          child: Container(
            height: 300,
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
                      height: 300,
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
                              date,
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
                              day,
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
                              month,
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
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderNo,
                                  style: const TextStyle(
                                    color: AppColor.appBarColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(
                                  width: 100,
                                ),
                                const Icon(
                                  MdiIcons.currencyUsd,
                                  size: 25,
                                  color: AppColor.appBarColor,
                                ),
                                Text(
                                  price,
                                  style: const TextStyle(
                                    color: AppColor.appBarColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
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
                            const Divider(
                              color: AppColor.greyColor,
                              thickness: 2,
                              // Add this line
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
                            const Divider(
                              color: AppColor.greyColor,
                              thickness: 2,
                              // Add this line
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
                              height: 40,
                            ),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  infoColumn("Time", time),
                                  const VerticalDivider(
                                    color: AppColor.greyColor,
                                  ),
                                  infoColumn("Weight", "$weight kg"),
                                  const VerticalDivider(
                                    color: AppColor.greyColor,
                                  ),
                                  infoColumn("Distance", "$distance km"),
                                  const VerticalDivider(
                                    color: AppColor.greyColor,
                                  ),
                                  infoColumn("Type", "$type"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColor.appBarColor,
        ),
      ),
      Text(
        data,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColor.infoTextColor,
        ),
      ),
    ],
  );
}
