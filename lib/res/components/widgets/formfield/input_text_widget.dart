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
  final String initialValue; // add this line
  final profileVM = Get.put(ProfileViewModel());
  InputTextField({
    Key? key,
    required this.controller,
    required this.icons,
    this.number = false,
    required this.hintText,
    this.initialValue = '',
  }): super(key: key) {
    controller.text = initialValue; // set initial value to controller here
  }

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
         profileVM.nameFocusNode.value,
          profileVM.regNumberFocusNode.value,
          profileVM.cityFocusNode.value,
          profileVM.stateFocusNode.value,
          profileVM.addressNode.value,
          profileVM.zipFocusNode.value,
        );
      },
      cursorColor: Colors.grey,
      style: TextStyle(color: AppColor.blackColor,fontSize: 16,fontWeight: FontWeight.w400),
      decoration: InputDecoration(

       prefixIcon: Icon(icons,color: AppColor.darkerColor),
        contentPadding: const EdgeInsets.symmetric(vertical: 18,horizontal: 20),
        border: InputBorder.none,
       // fillColor: const Color.fromARGB(255, 251, 250, 249),
       // filled: true,
        suffixIconColor: Colors.grey,


        //fillColor: const Color.fromARGB(255, 251, 250, 249),
        fillColor: Colors.transparent,

        filled: true,

        labelText: hintText,
        labelStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 17,
        ),
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
