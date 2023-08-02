import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/appbar/profile_app_bar.dart';
import 'package:celient_project/view/google_map_load_detail/google_map_load_detail_view.dart';
import 'package:celient_project/view/profile/profile_view.dart';
import 'package:celient_project/view/vehicle/vehicle_view.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class ProfileTabBarView extends StatelessWidget {
  const ProfileTabBarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: ProfileTabBar(),
        body: SafeArea(
          child: TabBarView(
            children: [
              ProfileView(),
              VehicleView(),
            ],
          ),
        ),
      ),
    );
  }
}


/// ============ DEtails
// Dimension = length , width , height, weight
//
