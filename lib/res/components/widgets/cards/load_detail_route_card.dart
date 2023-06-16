import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/view_model/controller/card/card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoadDetailRouteCard extends StatelessWidget {
  final String pickupName;
  final String pickupAddress;
  final String pickupDateTime;
  final String piece;
  final String dims;
  final String weight;
  final String deliveryName;
  final String deliveryAddress;
  final String deliveryTime;
  final CardController _cardController = Get.put(CardController());
  LoadDetailRouteCard(
      {Key? key,
      required this.pickupName,
      required this.pickupAddress,
      required this.pickupDateTime,
      required this.piece,
      required this.dims,
      required this.weight,
      required this.deliveryName,
      required this.deliveryAddress,
      required this.deliveryTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        return
            // height: _cardController.cardHeight.value,
            AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _cardController.isExpanded.value ? 500 : 60,
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
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: AppColor.whiteColor,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Route',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: AppColor.textColor,
                          fontSize: 20,
                        ),
                      ),
                      // IconButton(
                      //   onPressed: _cardController.toggleCardVisibility,
                      //   icon: const Icon(
                      //     MdiIcons.menuUp,
                      //     size: 35,
                      //     color: AppColor.greyColor,
                      //   ),
                      // ),
                    ],
                  ),
                  const Divider(
                    color: AppColor.greyColor,
                    thickness: 1,
                  ),
                  Visibility(
                    visible: _cardController.isExpanded.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pick-up point',
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: AppColor.greyColor,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          pickupName,
                          style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            color: AppColor.blackColor,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          pickupAddress,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          pickupDateTime,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                        const SizedBox(height: 20,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              MdiIcons.arrowUp,
                              size: 35,
                              color: AppColor.textColor,
                            ),
                            SizedBox(width: 15,),
                            Text(
                              'Cargo Details',
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: AppColor.textColor,
                                fontSize: 20,
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 20,),

                        RichText(
                          text: const TextSpan(
                              text: 'Cargo',
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: AppColor.blackColor,
                                fontSize: 19,
                              ),
                              children: <TextSpan>[
                                TextSpan(text: ' (not stackable, not turnable)',
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.greyColor, fontSize: 15),

                                )
                              ]
                          ),
                        ),

                        const SizedBox(height: 20,),

                        RichText(
                          text:  TextSpan(
                              text: 'Pieces',
                              style: const TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.greyColor, fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(text: '                      $piece',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.blackColor, fontSize: 16),

                                )
                              ]
                          ),
                        ),
                        const SizedBox(height: 5,),
                        RichText(
                          text:  TextSpan(
                              text: 'Dims (LxWxH)',
                              style: const TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.greyColor, fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(text: '    $dims',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.blackColor, fontSize: 16),

                                )
                              ]
                          ),
                        ),
                        const SizedBox(height: 5,),
                        RichText(
                          text:  TextSpan(
                              text: 'Weight',
                              style: const TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.greyColor, fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(text: '                  $weight lb',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.blackColor, fontSize: 16),

                                )
                              ]
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Text(
                          'Delivery point',
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: AppColor.greyColor,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          deliveryName,
                          style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            color: AppColor.blackColor,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          deliveryAddress,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          deliveryTime,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
