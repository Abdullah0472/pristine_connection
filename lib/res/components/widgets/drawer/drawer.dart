import 'package:celient_project/res/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../assets/images.dart';
import '../../../colors/colors.dart';
import '../text/text_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColor.applicationColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(ImageAssets.companyLogo),
                  ),
                ),
                const SizedBox(height: 9.0),
                //These can go here or below the header with the same background color
                Divider(
                  color: Colors.grey.shade400, //color of divider
                  height: 3, //height spacing of divider
                  thickness: 2, //thickness of divier line
                  indent: 5, //spacing at the start of divider
                  endIndent: 35, //spacing at the end of divider
                ),
                const SizedBox(height: 5.0),
                customText(
                  "Pristine Connection, LLC",
                  false,
                  size: 19,
                ),
                // customText("032382584", false, size: 15),
                //...additional header items here
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              MdiIcons.textBox,
              color: AppColor.drawerIconColor,
              size: 30,
            ),
            title: customText("Load Board", true),
            onTap: () {
              // Get.toNamed(RouteName.homeView);
              // Get.to(() => PracticeReviewPage(deviceIds: 48,));
            },
          ),
          ListTile(
            leading: const Icon(
              MdiIcons.fileDocument,
              color: AppColor.drawerIconColor,
              size: 30,
            ),
            title: customText("Reports", true),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.history,
              color: AppColor.drawerIconColor,
              size: 30,
            ),
            title: customText("History", true),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              MdiIcons.bookOpenPageVariant,
              color: AppColor.drawerIconColor,
              size: 30,
            ),
            title: customText("Privacy Policy", true),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              MdiIcons.accountCircle,
              color: AppColor.drawerIconColor,
              size: 30,
            ),
            title: customText("Profile", true),
            onTap: () {
               Get.toNamed(RouteName.profileView);
            },
          ),
          ListTile(
            leading: const Icon(
              MdiIcons.logout,
              color: AppColor.drawerIconColor,
              size: 30,
            ),
            title: customText("LogOut", true),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
