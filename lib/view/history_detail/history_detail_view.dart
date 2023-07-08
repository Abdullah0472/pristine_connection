import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/image/image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HistoryDetailView extends StatelessWidget {
  final String pickupName;
  final String pickupAddress;
  final String pickupDateTime;
  final String piece;
  final String dims;
  final String weight;
  final String deliveryName;
  final String deliveryAddress;
  final String deliveryTime;
  final String orderNo;
  final String price;
  final String date;
  final String day;
  final String month;
  final String deliverDate;
  final String deliverDay;
  final String deliverMonth;
  final String podImage;
  final String unloadingImage;
  const HistoryDetailView(
      {Key? key,
      required this.pickupName,
      required this.pickupAddress,
      required this.pickupDateTime,
      required this.piece,
      required this.dims,
      required this.weight,
      required this.deliveryName,
      required this.deliveryAddress,
      required this.deliveryTime,
      required this.orderNo,
      required this.price,
      required this.date,
      required this.day,
      required this.month,
      required this.deliverDate,
      required this.deliverDay,
      required this.deliverMonth, required this.podImage, required this.unloadingImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      appBar: const CustomAppBar(
          title: "Details", action: [SizedBox()], leadingIcon: SizedBox()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.blueColorShade800, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 3.0,
                    spreadRadius: 3.0,
                    offset: const Offset(
                      1.0,
                      1.0,
                    ),
                  )
                ],
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: AppColor.whiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderNo,
                            style: const TextStyle(
                              color: AppColor.blueColorShade800,
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                MdiIcons.currencyUsd,
                                size: 25,
                                color: AppColor.blueColorShade800,
                              ),
                              Text(
                                price,
                                style: const TextStyle(
                                  color: AppColor.blueColorShade800,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Pick-up point',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blueColorShade800,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        pickupName,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: AppColor.blackColor,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        pickupAddress,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                      const Divider(
                        color: AppColor.greyColor,
                        thickness: 3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Pick-up date & time',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: AppColor.darkerColor,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "$pickupDateTime  $day/$date/$month",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            MdiIcons.arrowUp,
                            size: 35,
                            color: AppColor.blueColorShade800,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Cargo Details',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              color: AppColor.blueColorShade800,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'Cargo',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              color: AppColor.darkerColor,
                              fontSize: 20,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' (not stackable, not turnable)',
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.greyColor,
                                    fontSize: 15),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Pieces',
                            style: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColor.greyColor,
                                fontSize: 18),
                            children: <TextSpan>[
                              TextSpan(
                                text: '                      $piece',
                                style: const TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.blackColor,
                                    fontSize: 18),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Dims (LxWxH)',
                            style: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColor.greyColor,
                                fontSize: 18),
                            children: <TextSpan>[
                              TextSpan(
                                text: '    $dims',
                                style: const TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.blackColor,
                                    fontSize: 18),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Weight',
                            style: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColor.greyColor,
                                fontSize: 18),
                            children: <TextSpan>[
                              TextSpan(
                                text: '                  $weight lb',
                                style: const TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.blackColor,
                                    fontSize: 18),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Delivery point',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blueColorShade800,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        deliveryName,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: AppColor.blackColor,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        deliveryAddress,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                      const Divider(
                        color: AppColor.greyColor,
                        thickness: 3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Deliver date & time',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: AppColor.darkerColor,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "$deliveryTime  $deliverDay/$deliverDate/$deliverMonth",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'POD Picture',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blueColorShade800,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Center(
                        child:ImagePicker(podImage),
                      ),
                      SizedBox(height: 20,),
                      const Text(
                        'Place of Unloading Picture',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blueColorShade800,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Center(
                        child: ImagePicker(unloadingImage),
                      ),
                      SizedBox(height: 20,),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
