import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/view_model/controller/card/card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoadDetailGeneralInfoCards extends StatelessWidget {
  final String miles;
  final String weight;
  final String pieces;
  final CardController _cardController = Get.put(CardController());

  LoadDetailGeneralInfoCards(
      {Key? key,
      required this.miles,
      required this.weight,
      required this.pieces})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        return
            // height: _cardController.cardHeight.value,
            AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _cardController.isExpanded.value ? 280 : 60,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'General Info',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: AppColor.textColor,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        onPressed: _cardController.toggleCardVisibility,
                        icon: const Icon(
                          MdiIcons.menuUp,
                          size: 35,
                          color: AppColor.greyColor,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: AppColor.greyColor,
                    thickness: 1,
                  ),
                  Visibility(
                    visible: _cardController.isExpanded.value,
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.domain,
                              size: 45,
                              color: AppColor.textColor,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Company',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.blackColor,
                                    fontSize: 20,
                                  ),
                                  overflow: TextOverflow.visible,
                                ),
                                Text(
                                  'Pristine Connections LLC',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.blackColor,
                                    fontSize: 18,
                                  ),
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              MdiIcons.mapMarkerCheck,
                              size: 45,
                              color: AppColor.textColor,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Loaded Miles',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.blackColor,
                                    fontSize: 20,
                                  ),
                                  overflow: TextOverflow.visible,
                                ),
                                Text(
                                  '$miles mi',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.blackColor,
                                    fontSize: 18,
                                  ),
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              MdiIcons.fileTable,
                              size: 45,
                              color: AppColor.textColor,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total Cargo',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.blackColor,
                                    fontSize: 20,
                                  ),
                                  overflow: TextOverflow.visible,
                                ),
                                Text(
                                  '$pieces pcs, $weight lb',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.blackColor,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                          ],
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
