import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view_model/controller/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../colors/colors.dart';

// ignore: must_be_immutable
class InputTextField extends StatelessWidget {
  final IconData icons;
  TextEditingController controller;
  final bool number;
  final String hintText;
  final profileVM = Get.put(ProfileViewModel());
  InputTextField({
    super.key,
    required this.controller,
    required this.icons,
    this.number = false,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: number ? TextInputType.phone : TextInputType.emailAddress,
      onFieldSubmitted: (value) {
        Utils.fieldFocusReviewChange(
          context,
        profileVM.emailFocusNode.value,
          profileVM.phoneNumberFocusNode.value,
            profileVM.licenceNumberFocusNode.value,
          profileVM.truckNumberFocusNode.value,
        );
      },
      cursorColor: Colors.grey,
      style: TextStyle(color: AppColor.blackColor,fontSize: 16,fontWeight: FontWeight.w400),
      decoration: InputDecoration(

       prefixIcon: Icon(icons,color: AppColor.darkerColor),
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: InputBorder.none,
       // fillColor: const Color.fromARGB(255, 251, 250, 249),
       // filled: true,
        suffixIconColor: Colors.grey,


        //fillColor: const Color.fromARGB(255, 251, 250, 249),
        fillColor: Colors.transparent,

        filled: true,

        hintText: hintText,
        hintStyle:  TextStyle(
          color: Colors.grey.shade400,
          fontSize: 16,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColor.greyColor, width: 1.3)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
            borderSide: const BorderSide(color: AppColor.greyColor, width: 1.3)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColor.redColor, width: 1.3)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColor.greyColor, width: 1.3)),
      ),
    );
  }
}
