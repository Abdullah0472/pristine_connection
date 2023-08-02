import 'dart:async';
import 'package:celient_project/res/routes/routes_name.dart';
import 'package:celient_project/view_model/controller/loadDetail/loadDetail_view_model.dart';
import 'package:celient_project/view_model/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../colors/colors.dart';

class ProfileTabBar extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight = 120.0;
  UserPreference userPreference = UserPreference();

   ProfileTabBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: SafeArea(
        child: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(RouteName.updatePasswordView);
                },
                icon: const Icon(
                  MdiIcons.lockReset,
                  color: AppColor.blackColor,
                  size: 25,
                )),
            IconButton(
                onPressed: () {
                  userPreference.removeUser();
                  Get.back();
                },
                icon: const Icon(
                  MdiIcons.logout,
                  color: AppColor.blackColor,
                  size: 25,
                )),
          ],
          title: Text(
            'Profile',
            style: const TextStyle(
              color: AppColor.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: AppColor.textColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            tabs: [
              Tab(
                child: Text(
                  'Personal Detail',
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    color: AppColor.textColor,
                    fontSize: 20,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Vehicle Details',
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    color: AppColor.textColor,
                    fontSize: 20,
                  ),
                ),
              ),

            ],
          ),
          elevation: 0,
          backgroundColor: AppColor.whiteColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
