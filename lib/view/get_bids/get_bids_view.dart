import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/cards/all_bid_card.dart';
import 'package:celient_project/res/components/widgets/exception/general_exception.dart';
import 'package:celient_project/res/components/widgets/exception/internet_exceptions_widget.dart';
import 'package:celient_project/view_model/controller/get_bids/get_bids_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GetBidView extends StatefulWidget {
  const GetBidView({Key? key}) : super(key: key);

  @override
  State<GetBidView> createState() => _GetBidViewState();
}

class _GetBidViewState extends State<GetBidView> {
  final getBidsVM = Get.put(GetBidsController());
  DateTime? parsedDatedeliver;
  DateTime? parsedDatepickup;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBidsVM.bidsListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      appBar:  const CustomAppBar(
        actionIcon: false,
        action: [Text('')],
        title: 'Your Bids',
        leadingIcon: SizedBox(),
      ),
      body: SafeArea(child: Obx(() {
        switch (getBidsVM.rxRequestStatus.value) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            if (getBidsVM.error.value == 'No internet') {
              return InterNetExceptionWidget(
                onPress: () {
                  getBidsVM.refreshApi();
                },
              );
            } else {
              return GeneralExceptionWidget(onPress: () {
                getBidsVM.refreshApi();
              });
            }
          case Status.COMPLETED:
            return (getBidsVM.bidsList.value.data!.isNotEmpty)
                ? SizedBox(
                    height:
                        Get.height, // Or any other height that makes sense in your app
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: getBidsVM.bidsList.value.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          var deliveryDateString = getBidsVM
                              .bidsList.value.data![index].deliveryDate;
                          var pickupDateString =
                              getBidsVM.bidsList.value.data![index].pickupDate;

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

                          // try {
                          //   parsedDatedeliver =
                          //       DateFormat('yyyy-MM-dd HH:mm:ss').parse(
                          //           getBidsVM.bidsList.value.data![index]
                          //               .deliveryDate
                          //               .toString());
                          // } catch (e) {
                          //   print('Failed to parse date: $e');
                          //   // Handle the error in a way that makes sense for your application
                          // }
                          //
                          // try {
                          //   parsedDatepickup = DateFormat('yyyy-MM-dd HH:mm:ss')
                          //       .parse(getBidsVM
                          //           .bidsList.value.data![index].pickupDate
                          //           .toString());
                          // } catch (e) {
                          //   print('Failed to parse date: $e');
                          //   // Handle the error in a way that makes sense for your application
                          // }
                          return BidCard(
                            // month: DateFormat('MMMM').format(parsedDatepickup!),
                            // date: DateFormat('d').format(parsedDatepickup!),
                            // day: DateFormat('EEEE').format(parsedDatepickup!),
                            month: parsedDatepickup != null
                                ? DateFormat('MMMM').format(parsedDatepickup!)
                                : "no month",
                            date: parsedDatepickup != null
                                ? DateFormat('d').format(parsedDatepickup!)
                                : "no date",
                            day: parsedDatepickup != null
                                ? DateFormat('EEEE').format(parsedDatepickup!)
                                : "no day",
                            orderNo: getBidsVM.bidsList.value.data![index].loadId
                                .toString(),
                            price: getBidsVM.bidsList.value.data![index].amount
                                .toString()
                                .obs,
                            pickupAddress: getBidsVM
                                .bidsList.value.data![index].pickupLocation
                                .toString(),
                            deliverAddress: getBidsVM
                                .bidsList.value.data![index].deliveryLocation
                                .toString(),
                            weight: getBidsVM.bidsList.value.data![index].weight
                                .toString(),
                            distance: getBidsVM
                                .bidsList.value.data![index].miles
                                .toString(),
                            type: getBidsVM
                                .bidsList.value.data![index].vehicleTypes
                                .toString(),
                            piece: '5',
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
                            dimension: getBidsVM
                                .bidsList.value.data![index].dims
                                .toString(),
                            stackable: 'Yes',
                            hazardous: 'No',
                            dockLevel: 'No',
                            note: getBidsVM.bidsList.value.data![index].message
                                .toString(),
                            onPress: (){
                              getBidsVM.cancelBidApi(getBidsVM.bidsList.value.data![index].bidId
                                  .toString());
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
