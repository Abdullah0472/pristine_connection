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
    allJobVM.addScrollListener();
    DateTime? parsedDate;
    DateTime? parsePickUpDate;
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
                            DateTime
                                .now()
                                .day == thisDate.day &&
                                DateTime
                                    .now()
                                    .month == thisDate.month;

                        return DateCard(
                          day: thisDate.day,
                          month: DateFormat('MMM').format(thisDate),
                          dayOfWeek: DateFormat('EEEE').format(thisDate),
                          isToday: DateTime.now().day == thisDate.day,
                          date: thisDate,
                        );

                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RoundButton(
                        title: 'Pending Bids',
                        onPress: () {
                          Get.toNamed(RouteName.getBidView);
                        },
                        width: 150,
                        height: 30,
                      ),
                      RoundButton(
                        title: 'Assigned Bids',
                        onPress: () {
                          Get.toNamed(RouteName.assignBidView);
                        },
                        width: 160,
                        height: 30,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Obx(() {
                    if (controller.isDateSelected) {
                      switch (allJobVM.rxRequestStatus.value) {
                        case Status.LOADING:
                          return  Column(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 10),
                              Text("Loading..."),
                            ],
                          );
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
                          if (allJobVM.loadsList.value.data == null ||
                              allJobVM.loadsList.value.data!.isEmpty){
                              return Center(child: Text("No Job Found"));

                          }
                          else {
                            return
                              Column(
                              children: [
                                SizedBox(
                                  height:
                                  650,
                                  // Or any other height that makes sense in your app
                                  child: ListView.builder(
                                      controller: allJobVM.scrollController,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount:
                                      allJobVM.loadsList.value.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        try {
                                          parsedDate = DateFormat(
                                              'yyyy-MM-dd HH:mm:ss')
                                              .parse(allJobVM.loadsList.value
                                              .data![index].deliveryDate
                                              .toString());
                                        } catch (e) {
                                          print('Failed to parse date: $e');
                                          // Handle the error in a way that makes sense for your application
                                          parsedDate = DateTime
                                              .now(); // provide a default value when parsing fails
                                        }


                                        String pickUpDateString = allJobVM.loadsList.value.data![index].pickupDate.toString();

                                        if (pickUpDateString != "ASAP") {
                                          try {
                                            parsePickUpDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(pickUpDateString);
                                          } catch (e) {
                                            print('Failed to parse date: $e');
                                            parsePickUpDate = DateTime.now(); // provide a default value when parsing fails
                                          }
                                        }


                                        return AllJobCards(
                                          pickUpmonth: pickUpDateString != "ASAP"
                                              ? DateFormat('MMMM').format(parsePickUpDate!)
                                              : '',
                                          pickUpdate: pickUpDateString != "ASAP"
                                              ? DateFormat('d').format(parsePickUpDate!)
                                              : 'ASAP',
                                          pickUpday: pickUpDateString != "ASAP"
                                              ? DateFormat('EEEE').format(parsePickUpDate!)
                                              : '',
                                          loadId: allJobVM
                                              .loadsList.value.data![index].id
                                              .toString(),
                                          price: allJobVM.price,
                                          pickupAddress: allJobVM.loadsList
                                              .value.data![index]
                                              .pickupLocation
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
                                          piece: allJobVM.loadsList.value
                                              .data![index].pieces
                                              .toString(),
                                          deliveryDay: parsedDate != null
                                              ? DateFormat('EEEE').format(
                                              parsedDate!)
                                              : 'N/A',
                                          deliveryYear: parsedDate != null
                                              ? DateFormat('MMMM').format(
                                              parsedDate!)
                                              : 'N/A',
                                          deliveryDate: parsedDate != null
                                              ? DateFormat('d').format(
                                              parsedDate!)
                                              : 'N/A',
                                          dimension: allJobVM
                                              .loadsList.value.data![index]
                                              .dims
                                              .toString(),
                                          stackable: allJobVM.loadsList.value
                                              .data![index].stackable
                                              .toString(),
                                          hazardous: allJobVM.loadsList.value
                                              .data![index].hazardous
                                              .toString(),
                                          dockLevel: allJobVM.loadsList.value
                                              .data![index].dockLevel
                                              .toString(),
                                          note: allJobVM.loadsList.value
                                              .data![index].notes
                                              .toString(),
                                        );
                                      }),
                                ),
                                if (allJobVM.isLoadingNextOffset.value)
                                  CircularProgressIndicator(),
                              ],
                            );
                          }
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
