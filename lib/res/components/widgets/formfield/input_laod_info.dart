import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view_model/controller/loadDetail/loadDetail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputReviewTextField extends StatelessWidget {
  final IconData icons;
  TextEditingController controller;
  final String hintText;
  final loadVM = Get.put(loadDetailViewModel());
  InputReviewTextField({
    super.key,
    required this.controller,
    required this.icons, required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onFieldSubmitted: (value) {
        Utils.fieldInfoDetailChange(
          context,
          loadVM.pieceFocusNode.value,
          loadVM.totalWeightFocusNode.value,
          loadVM.bolNumberFocusNode.value,
          loadVM.unloadByFocusNode.value,
        );
      },
      cursorColor: Colors.grey,
      keyboardType: TextInputType.phone,
      style: const TextStyle(color: AppColor.blackColor,fontSize: 16,fontWeight: FontWeight.w400),
      decoration: InputDecoration(

        prefixIcon: Icon(icons,color: AppColor.darkerColor),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
