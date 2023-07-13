import 'package:celient_project/res/colors/colors.dart';

import 'package:celient_project/view_model/controller/all_jobs/all_jobs_view_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateCard extends StatelessWidget {
  final int day;
  final String month;
  final String dayOfWeek;
  final bool isToday;
  final DateTime date;

  const DateCard({
    Key? key,
    required this.day,
    required this.month,
    required this.dayOfWeek,
    this.isToday = false,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datePickerController = Get.find<AllJobViewModel>();

    // bool isSelected = datePickerController.selectedDate.value?.day == day &&
    //     datePickerController.selectedDate.value?.month == date.month &&
    //     datePickerController.selectedDate.value?.year == date.year;

    bool isSelected = datePickerController.selectedDate.value?.day == day;

    return GestureDetector(
      onTap: () {
       // datePickerController.selectDate(DateTime(datePickerController.now.year, datePickerController.now.month, day));
        datePickerController.selectDate(DateTime(date.year, date.month, day));

      },

      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? Colors.green : (isToday ? AppColor.blueColorShade800 : AppColor.applicationColor),
            borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),

        width: 65,
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
