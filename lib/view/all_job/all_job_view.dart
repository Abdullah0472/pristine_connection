import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/cards/all_job_cards.dart';
import 'package:celient_project/res/components/widgets/cards/date_cards.dart';
import 'package:celient_project/res/components/widgets/dialoge_box/dialoge_box_job_filter.dart';
import 'package:celient_project/view_model/controller/datePicker/datePicker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AllJobView extends StatelessWidget {
  const AllJobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    return GetBuilder<DatePickerController>(
      init: DatePickerController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
              title: "All Jobs",
              action: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return JobFilterDialogBox();
                    },
                  );
                },
                icon: Icon(
                  MdiIcons.filterMultiple,
                  size: 30,
                  color: AppColor.blackColor,
                ),
              ),
              actionIcon: true,
              leadingIcon: SizedBox()),
          backgroundColor: AppColor.offWhite,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: daysInMonth,
                      itemBuilder: (BuildContext ctx, int index) {
                        final DateTime day =
                            DateTime(now.year, now.month, index + 1);
                        final bool isToday = DateTime.now().day == day.day;
                        return DateCard(
                          day: day.day,
                          month: DateFormat('MMMM').format(day),
                          dayOfWeek: DateFormat('EEE').format(day),
                          isToday: isToday,
                        );
                      },
                    ),
                  ),
                  Obx(() {
                    if (controller.isDateSelected) {
                      return SizedBox(
                        height:
                            MediaQuery.of(context).size.height, // Or any other height that makes sense in your app
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return AllJobCards(
                                month: controller.selectedMonth ??
                                    'No month selected',
                                date: controller.selectedDayDate ??
                                    'No date selected',
                                day: controller.selectedDay ??
                                    'No year selected',
                                orderNo: "554",
                                price: "3500",
                                pickupAddress:
                                    "40 Business Man Colony Near Paprika Resturant and Nursery Ground Rahim yar khan",
                                deliverAddress:
                                    'Jinnah Park Street Number 45 House Number 71, Near Allah hu Chock, Rahim Yar Khan',
                                time: '08:05',
                                weight: '9',
                                distance: '8',
                                type: 'container', piece: '5',
                              );
                            }),
                      );
                    } else {
                      return const SizedBox();
                    }
                  })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
