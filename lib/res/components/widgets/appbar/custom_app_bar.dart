import 'package:celient_project/res/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../colors/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight = 60.0;
  final String title;
  final bool icon;
  final bool actionIcon;
  final List<Widget> action; // Update the type to List<Widget>
  final Widget leadingIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actionIcon = false,
    this.icon = false,
    required this.action, required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: SafeArea(
        child: AppBar(
          actions: actionIcon == true ? action : [],
          iconTheme: const IconThemeData(color: AppColor.blackColor),
          leading: icon == true
              ? Builder(
                  builder: (context) => leadingIcon
                  //     IconButton(
                  //   onPressed: () {
                  //    Get.toNamed(RouteName.allJobVIew);
                  //   },
                  //   icon: const Icon(
                  //     Icons.history,
                  //     size: 30,
                  //     color: AppColor.blackColor,
                  //   ),
                  // ),
                )
              : Builder(
                  builder: (context) => IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      MdiIcons.arrowLeft,
                      size: 30,
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
          title: Text(
            title,
            style: const TextStyle(
              color: AppColor.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
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
