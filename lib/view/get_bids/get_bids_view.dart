import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/res/assets/images.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/cards/all_job_cards.dart';
import 'package:celient_project/res/components/widgets/cards/history_job_card.dart';
import 'package:celient_project/res/components/widgets/exception/general_exception.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetBidView extends StatelessWidget {
  const GetBidView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      appBar: const CustomAppBar(
        icon: true,
        actionIcon: false,
        action: [Text('')],
        title: 'Your Bids',
        leadingIcon: SizedBox(),
      ),
      body: SafeArea(
        child: Container(),
        // child: Obx(() {
        //
        //     switch (allJobVM.rxRequestStatus.value) {
        //       case Status.LOADING:
        //         return const Center(
        //             child: CircularProgressIndicator());
        //       case Status.ERROR:
        //         if (allJobVM.error.value == 'No internet') {
        //           return InterNetExceptionWidget(
        //             onPress: () {
        //               allJobVM.refreshApi();
        //             },
        //           );
        //         } else {
        //           return GeneralExceptionWidget(onPress: () {
        //             allJobVM.refreshApi();
        //           });
        //         }
        //       case Status.COMPLETED:
        //         return (allJobVM.loadsList.value.data!.isNotEmpty)
        //             ? SizedBox(
        //           height:
        //           650, // Or any other height that makes sense in your app
        //           child: ListView.builder(
        //               physics: const BouncingScrollPhysics(),
        //               itemCount:
        //               allJobVM.loadsList.value.data!.length,
        //               itemBuilder:
        //                   (BuildContext context, int index) {
        //
        //
        //                 return AllJobCards(
        //                   month: controller.selectedMonth ??
        //                       'No month selected',
        //                   date: controller.selectedDayDate ??
        //                       'No date selected',
        //                   day: controller.selectedDay ??
        //                       'No year selected',
        //                   orderNo: allJobVM
        //                       .loadsList.value.data![index].id.toString(),
        //                   price: allJobVM.price,
        //                   pickupAddress: allJobVM.loadsList
        //                       .value.data![index].pickupLocation
        //                       .toString(),
        //                   deliverAddress: allJobVM
        //                       .loadsList
        //                       .value
        //                       .data![index]
        //                       .deliveryLocation
        //                       .toString(),
        //                   weight: allJobVM.loadsList.value
        //                       .data![index].weight
        //                       .toString(),
        //                   distance: allJobVM.loadsList.value
        //                       .data![index].miles
        //                       .toString(),
        //                   type: allJobVM.loadsList.value
        //                       .data![index].vehicleTypes
        //                       .toString(),
        //                   piece: '5',
        //                   deliveryDay: DateFormat('EEEE')
        //                       .format(parsedDate!), // 'Tuesday'
        //                   deliveryYear: DateFormat('MMMM')
        //                       .format(parsedDate!), // 'July'
        //                   deliveryDate: DateFormat('d')
        //                       .format(parsedDate!), // '5'
        //                   dimension: allJobVM
        //                       .loadsList.value.data![index].dims
        //                       .toString(),
        //                   stackable: 'Yes',
        //                   hazardous: 'No',
        //                   dockLevel: 'No',
        //                   note: 'This is the note ',
        //                 );
        //               }),
        //         )
        //             : Center(child: Text('No Job Found'));
        //     }
        //
        // })
      ),
    );
  }
}
