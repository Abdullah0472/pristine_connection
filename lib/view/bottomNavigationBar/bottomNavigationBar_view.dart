// ignore: file_names
import 'dart:io';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/navigationBar/navigationBar.dart';
import 'package:celient_project/view/chats/chats_view.dart';
import 'package:celient_project/view/connection/connection_view.dart';
import 'package:celient_project/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../profile/profile_view.dart';


class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  int _selectedIndex = 0;

  final List _widgetOptions = [
    ///------------ Name of The Screens/View ------------------- ///

    /// Will Be Moving To Home Screen

    HomeView(),

    /// Will Be Moving To Connection Screen

    ConnectionView(),
    ///Will Be Moving To Chats Screen

    ChatsView(),
    ///Will Be Moving To Profile View Screen
    // CustomInspectionView(),
    ProfileView(),
  ];

  _onItemTapped(var index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Close the app when the back button is pressed
      onWillPop: () async {
        // Close the app when the back button is pressed
        SystemNavigator.pop();
        return Future.value(false); // Return false to allow the app to close
      },
      child: Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: CustomAnimatedBottomBar(
            containerHeight: 60,
            backgroundColor: AppColor.whiteColor,
            selectedIndex: _selectedIndex,
            showElevation: true,
            itemCornerRadius: 10,
            curve: Curves.easeIn,
            onItemSelected: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            onTap: () {
              _onItemTapped(_selectedIndex);
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                icon: const Icon(
                  MdiIcons.packageVariantClosed,
                  size: 30,
                ),
                title:  Text(
                 "Loads",
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                activeColor: AppColor.appBarColor,
                inactiveColor: AppColor.blackColor,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: const Icon(
                  MdiIcons.lanConnect,
                  size: 34,
                ),
                title:  Text(
                  'Connection',
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                activeColor: AppColor.applicationColor,
                inactiveColor: AppColor.blackColor,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: const Icon(
                  MdiIcons.chat,
                  size: 34,
                ),
                title:  Text(
                  'Chat',
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                activeColor: AppColor.redShadeColor,
                inactiveColor: AppColor.blackColor,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: const Icon(
                  MdiIcons.accountCircle,
                  size: 34,
                ),
                title:  Text(
                  'Profile',
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                activeColor: AppColor.pinkShadeColor,
                inactiveColor: AppColor.blackColor,
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }
}
