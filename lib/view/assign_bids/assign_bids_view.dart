import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/cards/all_bid_card.dart';
import 'package:celient_project/res/components/widgets/exception/general_exception.dart';
import 'package:celient_project/res/components/widgets/exception/internet_exceptions_widget.dart';
import 'package:celient_project/view_model/controller/all_jobs/all_jobs_view_model.dart';
import 'package:celient_project/view_model/controller/assign_bids/asign_bids_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AssignBidView extends StatefulWidget {
  const AssignBidView({Key? key}) : super(key: key);

  @override
  State<AssignBidView> createState() => _AssignBidViewState();
}
class _AssignBidViewState extends State<AssignBidView> {
  final assignBidsVM = Get.put(AssignBidsController());
  final allJobVM = Get.put(AllJobViewModel());
  DateTime? parsedDatedeliver;
  DateTime? parsedDatepickup;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assignBidsVM.assignBidsListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      appBar:   CustomAppBar(
        icon: true,
        actionIcon: false,
        action: [Text('')],
        title: 'Assigned Bids',
        leadingIcon: IconButton(onPressed: (){
          allJobVM.offset = 0; // Reset the offset to 0
          allJobVM.loadsList.value.data = []; // Clear the list of jobs
          // allJobVM.loadsList
          //     .refresh(); // Notify listeners to rebuild the view and clear the previous data
          allJobVM.setRxRequestStatus(Status.LOADING);
          allJobVM.userListApi();
          Get.back();
        }, icon: Icon(
          MdiIcons.arrowLeft,
          size: 30,
          color: AppColor.blackColor,
        ),),
      ),
      body: SafeArea(child: Obx(() {
        switch (assignBidsVM.rxRequestStatus.value) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            if (assignBidsVM.error.value == 'No internet') {
              return InterNetExceptionWidget(
                onPress: () {
                  assignBidsVM.refreshApi();
                },
              );
            } else {
              return GeneralExceptionWidget(onPress: () {
                assignBidsVM.refreshApi();
              });
            }
          case Status.COMPLETED:
            return (assignBidsVM.assignbidsList.value.data!.isNotEmpty)
                ? SizedBox(
              height:
              Get.height, // Or any other height that makes sense in your app
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: assignBidsVM.assignbidsList.value.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var deliveryDateString = assignBidsVM
                        .assignbidsList.value.data![index].deliveryDate;
                    var pickupDateString =
                        assignBidsVM.assignbidsList.value.data![index].pickupDate;

                    if (deliveryDateString != null) {
                      try {
                        parsedDatedeliver =
                            DateFormat('yyyy-MM-dd HH:mm:ss')
                                .parse(deliveryDateString.toString());
                      } catch (e) {
                        print('Failed to parse delivery date: $e');
                        // Handle the error in a way that makes sense for your application
                      }
                    }

                    if (pickupDateString != null) {
                      try {
                        parsedDatepickup =
                            DateFormat('yyyy-MM-dd HH:mm:ss')
                                .parse(pickupDateString.toString());
                      } catch (e) {
                        print('Failed to parse pickup date: $e');
                        // Handle the error in a way that makes sense for your application
                      }
                    }

                    return BidCard(
                      roundButtonText: "START",
                      month: parsedDatepickup != null
                          ? DateFormat('MMMM').format(parsedDatepickup!)
                          : "no month",
                      date: parsedDatepickup != null
                          ? DateFormat('d').format(parsedDatepickup!)
                          : "no date",
                      day: parsedDatepickup != null
                          ? DateFormat('EEEE').format(parsedDatepickup!)
                          : "no day",
                      orderNo:
                      assignBidsVM.assignbidsList.value.data![index].loadId
                          .toString(),
                      price:
                      assignBidsVM.assignbidsList.value.data![index].amount
                          .toString()
                          .obs,
                      pickupAddress: assignBidsVM.assignbidsList.value.data![index].pickupLocation
                          .toString(),
                      deliverAddress: assignBidsVM.assignbidsList.value.data![index].deliveryLocation
                          .toString(),
                      weight: assignBidsVM.assignbidsList.value.data![index].weight
                          .toString(),
                      distance: assignBidsVM.assignbidsList.value.data![index].miles
                          .toString(),
                      type: assignBidsVM.assignbidsList.value.data![index].loadVehicleTypes
                          .toString(),
                      piece: assignBidsVM.assignbidsList.value.data![index].pieces
                          .toString(),
                      deliveryDay:
                      // DateFormat('EEEE').format(parsedDatedeliver!),
                      parsedDatedeliver != null
                          ? DateFormat('EEEE').format(parsedDatedeliver!)
                          : "no day",
                      // 'Tuesday'
                      deliveryYear:
                      // DateFormat('MMMM').format(parsedDatedeliver!),
                      parsedDatedeliver != null
                          ? DateFormat('MMMM').format(parsedDatedeliver!)
                          : "no month",
                      // 'July'
                      deliveryDate:
                      // DateFormat('d').format(parsedDatedeliver!),
                      parsedDatedeliver != null
                          ? DateFormat('d').format(parsedDatedeliver!)
                          : "no date",
                      // '5'
                      dimension: assignBidsVM.assignbidsList.value.data![index].dims
                          .toString(),
                      stackable: assignBidsVM.assignbidsList.value.data![index].stackable
                          .toString(),
                      hazardous: assignBidsVM.assignbidsList.value.data![index].hazardous
                          .toString(),
                      dockLevel: 'No',
                      note: assignBidsVM.assignbidsList.value.data![index].notes
                          .toString(),
                      onPress: (){
                        // getBidsVM.cancelBidApi(getBidsVM.bidsList.value.data![index].bidId
                        //     .toString());
                      },
                    );
                  }),
            )
                : const Center(child: Text('No Bid Found'));
        }
      })),
    );
  }
}
