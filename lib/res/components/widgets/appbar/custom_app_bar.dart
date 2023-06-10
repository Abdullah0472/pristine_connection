import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../colors/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight = 60.0;
  final String title;
  final bool icon;
  final bool actionIcon;
  final Widget action;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actionIcon = false,
    this.icon = false,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: AppBar(
        actions: actionIcon == true
            ? [
                action
              ]
            : [],
        iconTheme: const IconThemeData(color: AppColor.whiteColor),
        leading: icon == true
            ? Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                ),
              )
            : IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.chevron_left)),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColor.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColor.applicationColor,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
