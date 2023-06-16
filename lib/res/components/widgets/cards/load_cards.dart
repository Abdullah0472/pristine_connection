import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/buttons/card_button.dart';
import 'package:celient_project/view/load_detail/load_detail_view.dart';
import 'package:celient_project/view/load_detail_tabBar/load_detail_tabBar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadCards extends StatelessWidget {
  final String refNumber;
  final String currentAddress;
  final String dateTime;
  final String piece;
  final String dims;
  final String weight;
  final String miles;
  final String pickupName;
  final String pickupAddress;
  final String pickupDateTime;
  final String deliveryName;
  final String deliveryAddress;
  final String deliveryDateTime;

  const LoadCards(
      {Key? key,
      required this.refNumber,
      required this.currentAddress,
      required this.dateTime,
      required this.piece,
      required this.dims,
      required this.weight,
      required this.miles,
      required this.pickupName,
      required this.pickupAddress,
      required this.pickupDateTime,
      required this.deliveryName,
      required this.deliveryAddress,
      required this.deliveryDateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 350,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'invia Ref.# $refNumber',
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: AppColor.greyColor,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        'In Transit to Pick-Up',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: AppColor.textColor,
                          fontSize: 20,
                        ),
                      ),
                      const Text(
                        'Pristine Connections LLC',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blackColor,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  CardButton(
                    title: 'More',
                    onPress: () {
                      Get.to(() => loadDetailTabBarView(
                            refNumber: refNumber,
                            currentAddress: currentAddress,
                            dateTime: dateTime,
                            piece: piece,
                            weight: weight,
                            dims: dims,
                            miles: miles,
                            pickupName: pickupName,
                            pickupAddress: pickupAddress,
                            pickupDateTime: pickupDateTime,
                            deliveryName: deliveryName,
                            deliveryAddress: deliveryAddress,
                            deliveryDateTime: deliveryDateTime,
                          ));
                    },
                    buttonColor: AppColor.whiteColor,
                    textColor: AppColor.textColor,
                    width: 80,
                    height: 40,
                  )
                ],
              ),
              const Divider(
                color: AppColor.greyColor,
                thickness: 2,
              ),
              const Text(
                'Current Location',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: AppColor.greyColor,
                  fontSize: 16,
                ),
              ),
              Text(
                currentAddress,
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
                height: 10,
              ),
              Text(
                dateTime,
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
      ),
    );
  }
}
