import 'package:celient_project/res/assets/images.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/cards/history_job_card.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      appBar: const CustomAppBar(
        icon: true,
        actionIcon: false,
        action: [Text('')],
        title: 'History',
        leadingIcon: SizedBox(),
      ),
      body: SafeArea(
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return HistoryJobCards(
                month: "July",
                date: '15',
                day: 'Wednesday',
                orderNo: "554",
                price: "3500",
                pickupAddress:
                    "40 Business Man Colony Near Paprika Resturant and Nursery Ground Rahim yar khan",
                deliverAddress:
                    'Jinnah Park Street Number 45 House Number 71, Near Allah hu Chock, Rahim Yar Khan',
                time: '08:05',
                weight: '9',
                distance: '8',
                type: 'container',
                piece: '7',
                deliverDate: '16',
                deliverDay: 'Friday',
                deliverMonth: 'June',
                deliverTime: '10:51', pickupName: 'Amjad Jamshed',
                deliverName: 'Dashiell', podImage: ImageAssets.lady, unloadingImage: ImageAssets.companyLogo,
              );
            }),
      ),
    );
  }
}
