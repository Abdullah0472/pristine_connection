import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/cards/load_detail_route_card.dart';
import 'package:celient_project/view_model/controller/datePicker/datePicker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateCard extends StatelessWidget {
  final int day;
  final String month;
  final String dayOfWeek;
  final bool isToday;

  const DateCard({
    Key? key,
    required this.day,
    required this.month,
    required this.dayOfWeek,
    this.isToday = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datePickerController = Get.find<DatePickerController>();
    return GestureDetector(
      onTap: () {
        datePickerController.selectDate(DateTime(DateTime.now().year, DateTime.now().month, day));
      },
      child: Container(
        decoration: BoxDecoration(
            color: isToday ? AppColor.blueColorShade800 : AppColor.applicationColor,
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),

        width: 60,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              month,
              style: const TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              day.toString(),
              style: const TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              dayOfWeek,
              style: const TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
