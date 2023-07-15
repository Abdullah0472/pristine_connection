import 'package:celient_project/res/colors/colors.dart';
import 'package:flutter/material.dart';

class LoadDetailCards extends StatelessWidget {
  final String loadId;
  final String currentAddress;
  final String dateTime;
  final String pieces;
 final String dims;
 final String weight;
  const LoadDetailCards({Key? key, required this.loadId, required this.currentAddress, required this.dateTime, required this.pieces, required this.dims, required this.weight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(

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
              Text(
                'Load Id. $loadId',
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
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackColor,
                  fontSize: 16.5,
                ),
              ),
              const Divider(
                color: AppColor.greyColor,
                thickness: 1,
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
              const SizedBox(height: 10,),
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
              const SizedBox(height: 20,),
              const Text(
                'Show Route',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  color: AppColor.textColor,
                  fontSize: 20,
                ),
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
                      TextSpan(text: '                      $pieces',
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
            ],
          ),
        ),
      ),
    );
  }
}
