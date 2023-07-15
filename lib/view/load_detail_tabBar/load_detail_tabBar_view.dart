import 'package:celient_project/res/components/widgets/appbar/loadInfoAppBar.dart';
import 'package:celient_project/view/google_map_load_detail/google_map_load_detail_view.dart';
import 'package:celient_project/view/load_detail/load_detail_view.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class loadDetailTabBarView extends StatelessWidget {
  final String loadId;
  final String currentAddress;
  final String dateTime;
  final String piece;
  final String dims;
  final String weight;
  final String miles;
  final String pickupName;
  final String pickupAddress;
  final String pickupDateTime;
  final String deliveryName;
  final String deliveryAddress;
  final String deliveryDateTime;
  const loadDetailTabBarView(
      {Key? key,
      required this.loadId,
      required this.currentAddress,
      required this.dateTime,
      required this.piece,
      required this.dims,
      required this.weight,
      required this.miles,
      required this.pickupName,
      required this.pickupAddress,
      required this.pickupDateTime,
      required this.deliveryName,
      required this.deliveryAddress,
      required this.deliveryDateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: LoadDetailTabBar(
          loadId: loadId,
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              LoadDetailView(
                loadId: loadId,
                currentAddress: currentAddress,
                dateTime: dateTime,
                piece: piece,
                dims: dims,
                weight: weight,
                miles: miles,
                deliveryDateTime: deliveryDateTime,
                pickupName: pickupName,
                pickupAddress: pickupAddress,
                pickupDateTime: pickupDateTime,
                deliveryName: deliveryName,
                deliveryAddress: deliveryAddress,
              ),
              GoogleMapTabBarVIew(),
            ],
          ),
        ),
      ),
    );
  }
}
