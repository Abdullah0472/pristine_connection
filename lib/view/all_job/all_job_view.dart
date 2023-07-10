import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/cards/all_job_cards.dart';
import 'package:celient_project/res/components/widgets/cards/date_cards.dart';
import 'package:celient_project/res/components/widgets/dialoge_box/dialoge_box_job_filter.dart';
import 'package:celient_project/res/components/widgets/exception/general_exception.dart';
import 'package:celient_project/res/components/widgets/exception/internet_exceptions_widget.dart';
import 'package:celient_project/res/routes/routes_name.dart';
import 'package:celient_project/view_model/controller/all_jobs/all_jobs_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AllJobView extends StatelessWidget {
  const AllJobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allJobVM = Get.put(AllJobViewModel());
    //  DateTime parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(allJobVM.loadsList.value.data![index].deliveryDate.toString());
    DateTime? parsedDate;
    return GetBuilder<AllJobViewModel>(
      init: allJobVM,
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
              title: "All Jobs",
              action: [
                IconButton(
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
              ],
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
                      itemCount: allJobVM.daysInMonth,
                      itemBuilder: (BuildContext ctx, int index) {
                        final thisDate = DateTime(
                            allJobVM.now.year, allJobVM.now.month, index + 1);
                        final bool isToday =
                            DateTime.now().day == thisDate.day &&
                                DateTime.now().month == thisDate.month;
                        return DateCard(
                          day: thisDate.day,
                          month: DateFormat('MMMM').format(thisDate),
                          dayOfWeek: DateFormat('EEE').format(thisDate),
                          isToday: isToday,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 5,),

                  RoundButton(title: 'See You Bids', onPress: (){
                    Get.toNamed(RouteName.getBidView);
                  },width: 150,height: 30,),
                  SizedBox(height: 5,),
                  Obx(() {
                    if (controller.isDateSelected) {
                      switch (allJobVM.rxRequestStatus.value) {
                        case Status.LOADING:
                          return const Center(
                              child: CircularProgressIndicator());
                        case Status.ERROR:
                          if (allJobVM.error.value == 'No internet') {
                            return InterNetExceptionWidget(
                              onPress: () {
                                allJobVM.refreshApi();
                              },
                            );
                          } else {
                            return GeneralExceptionWidget(onPress: () {
                              allJobVM.refreshApi();
                            });
                          }
                        case Status.COMPLETED:
                          return (allJobVM.loadsList.value.data!.isNotEmpty)
                              ? SizedBox(
                                  height:
                                      650, // Or any other height that makes sense in your app
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount:
                                          allJobVM.loadsList.value.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        try {
                                          parsedDate =
                                              DateFormat('yyyy-MM-dd HH:mm:ss')
                                                  .parse(allJobVM
                                                      .loadsList
                                                      .value
                                                      .data![index]
                                                      .deliveryDate
                                                      .toString());
                                        } catch (e) {
                                          print('Failed to parse date: $e');
                                          // Handle the error in a way that makes sense for your application
                                        }

                                        return AllJobCards(
                                          month: controller.selectedMonth ??
                                              'No month selected',
                                          date: controller.selectedDayDate ??
                                              'No date selected',
                                          day: controller.selectedDay ??
                                              'No year selected',
                                          orderNo: allJobVM
                                              .loadsList.value.data![index].id.toString(),
                                          price: allJobVM.price,
                                          pickupAddress: allJobVM.loadsList
                                              .value.data![index].pickupLocation
                                              .toString(),
                                          deliverAddress: allJobVM
                                              .loadsList
                                              .value
                                              .data![index]
                                              .deliveryLocation
                                              .toString(),
                                          weight: allJobVM.loadsList.value
                                              .data![index].weight
                                              .toString(),
                                          distance: allJobVM.loadsList.value
                                              .data![index].miles
                                              .toString(),
                                          type: allJobVM.loadsList.value
                                              .data![index].vehicleTypes
                                              .toString(),
                                          piece: '5',
                                          deliveryDay: DateFormat('EEEE')
                                              .format(parsedDate!), // 'Tuesday'
                                          deliveryYear: DateFormat('MMMM')
                                              .format(parsedDate!), // 'July'
                                          deliveryDate: DateFormat('d')
                                              .format(parsedDate!), // '5'
                                          dimension: allJobVM
                                              .loadsList.value.data![index].dims
                                              .toString(),
                                          stackable: 'Yes',
                                          hazardous: 'No',
                                          dockLevel: 'No',
                                          note: 'This is the note ',
                                        );
                                      }),
                                )
                              : Center(child: Text('No Job Found'));
                      }
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
