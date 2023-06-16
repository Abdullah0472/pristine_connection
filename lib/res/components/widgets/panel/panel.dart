
import 'package:celient_project/res/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;
  const PanelWidget({Key? key, required this.controller, required this.panelController}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
    controller: controller,
    padding: EdgeInsets.zero,
    children: [
      const SizedBox(height: 12,),
      buildDragHandle(),
      const SizedBox(height: 10,),
      buildAboutText(),
      const SizedBox(height: 26,),
    ],
  );

  Widget buildDragHandle() => GestureDetector(
    onTap: togglePanel,
    child: Center(
      child: Container(
        width: 30,
        height: 5,
        decoration: BoxDecoration(
          color: AppColor.greyColor,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );

  void togglePanel() => panelController.isPanelOpen
  ? panelController.close()
  : panelController.open();

  Widget buildAboutText() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         // SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Icon(MdiIcons.carOutline, size: 50, color: AppColor.blackColor,),
              Text('Car Type',style: TextStyle(color: AppColor.darkerColor, fontWeight: FontWeight.w500, fontSize: 18),),
              Text('Jeep',style: TextStyle(color: AppColor.greyColor, fontWeight: FontWeight.w400, fontSize: 16),)
            ],
          ),
         // SizedBox(width:60 ,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(MdiIcons.clipboardTextClockOutline, size: 50, color: AppColor.blackColor,),
              Text('Time',style: TextStyle(color: AppColor.darkerColor, fontWeight: FontWeight.w500, fontSize: 18),),
              Text('04:08 AM',style: TextStyle(color: AppColor.greyColor, fontWeight: FontWeight.w400, fontSize: 16),)
            ],
          ),
         // SizedBox(width: 50,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(MdiIcons.mapMarkerDistance, size: 50, color: AppColor.blackColor,),
              Text('Distance',style: TextStyle(color: AppColor.darkerColor, fontWeight: FontWeight.w500, fontSize: 18),),
              Text('48 KM',style: TextStyle(color: AppColor.greyColor, fontWeight: FontWeight.w400, fontSize: 16),),
            ],
          ),
        ],
      ),
        SizedBox(height: 10,),
        Divider(),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  MdiIcons.mapMarkerRadius,
                  size: 45,
                  color: AppColor.blackColor,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    'House Number 40, Business Man Colony, Near Paprika Restaurant, Rahim Yar Khan, Punjab, Pakistan',
                    style: TextStyle(
                      color: AppColor.greyColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )

      ],
    ),
  );
}
