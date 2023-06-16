import 'dart:async';
import 'package:celient_project/view_model/controller/loadDetail/loadDetail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../colors/colors.dart';

class LoadDetailTabBar extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight = 120.0;
  final String refNumber;

  const LoadDetailTabBar({
    Key? key,
    required this.refNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadDetailVM = Get.put(loadDetailViewModel());
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: SafeArea(
        child: AppBar(
         actions: [
           PopupMenuButton(
             itemBuilder: (context) => [
               PopupMenuItem(
                 onTap: () {
                   loadDetailVM.controller.future.then(
                         (value) {
                       DefaultAssetBundle.of(context)
                           .loadString('assets/maptheme/silver_theme.json')
                           .then(
                             (string) {
                           value.setMapStyle(string);
                         },
                       );
                     },
                   );
                 },
                 child: const Text('Silver'),
               ),
               PopupMenuItem(
                 onTap: () {
                   loadDetailVM.controller.future.then(
                         (value) {
                       DefaultAssetBundle.of(context)
                           .loadString('assets/maptheme/retro_theme.json')
                           .then(
                             (string) {
                           value.setMapStyle(string);
                         },
                       );
                     },
                   );
                 },
                 child: const Text('Retro'),
               ),
               PopupMenuItem(
                 onTap: () {
                   loadDetailVM.controller.future.then(
                         (value) {
                       DefaultAssetBundle.of(context)
                           .loadString('assets/maptheme/night_theme.json')
                           .then(
                             (string) {
                           value.setMapStyle(string);
                         },
                       );
                     },
                   );
                 },
                 child: const Text('Night'),
               ),
             ],
           ),
         ],
          leading: IconButton(
            icon: const Icon(
              MdiIcons.arrowLeft,
              size: 30,
              color: AppColor.blackColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'invia Ref.# $refNumber',
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
                  'Load Info',
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
                  'Map',
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