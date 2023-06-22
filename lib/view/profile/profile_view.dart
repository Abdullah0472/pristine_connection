import 'package:celient_project/res/animation/FadeAnimation.dart';
import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_text_widget.dart';
import 'package:celient_project/view_model/controller/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileVM = Get.put(ProfileViewModel());
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      appBar: const CustomAppBar(
        icon: true,
        actionIcon: false,
        action: Text(''),
        title: 'User Profile', leadingIcon: SizedBox(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 55),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               FadeAnimation(
              1.2,
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage('https://images.pexels.com/photos/6976943/pexels-photo-6976943.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                ),
              ),
              ),
            const SizedBox(height: 20,),
            FadeAnimation(
              1.4,
                InputTextField(
                  controller: profileVM.emailController.value,
                  icons: MdiIcons.emailOutline,
                  hintText: "Email",
                )
            ),
                const SizedBox(height: 20,),
                FadeAnimation(
                    1.6,
                    InputTextField(
                      number: true,
                      controller: profileVM.phoneNumberController.value,
                      icons: MdiIcons.phoneOutline,
                      hintText: "Phone Number",
                    ),

                ),
                const SizedBox(height: 20,),
                FadeAnimation(
                  1.8,
                  InputTextField(
                    number: true,
                    controller: profileVM.licenceNumberController.value,
                    icons: MdiIcons.license,
                    hintText: "Licence Number",
                  ),

                ),
                const SizedBox(height: 20,),
                FadeAnimation(
                 2 ,
                  InputTextField(
                    controller: profileVM.truckNumberController.value,
                    icons: MdiIcons.truckOutline,
                    hintText: "Truck Number",
                  ),

                ),
                const SizedBox(height: 30,),
                FadeAnimation(
                  2.2,
                  RoundButton(
                    loading: false,
                    width: 300,
                    height: Get.height * 0.06,
                    onPress: () {

                    },
                    title: 'Update the Profile',
                  ),

                ),

            ],),
          ),
        ),
      ),
    );
  }
}
