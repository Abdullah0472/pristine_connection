import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view_model/controller/all_jobs/all_jobs_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../colors/colors.dart';

// ignore: must_be_immutable
class InputJobFilterTextField extends StatelessWidget {
  TextEditingController controller;

  final String hint;
  // final String? Function(String?)? validator;
  final allJobVM = Get.put(AllJobViewModel());

  InputJobFilterTextField({
    Key? key,
    // required this.validator,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      //   validator: validator,
      controller: controller,
      onFieldSubmitted: (value) {
        Utils.fieldFocusChange(
          context,
          allJobVM.radiusFocusNode.value,
          allJobVM.postalCodeFocusNode.value,
        );
      },
      style: const TextStyle(
        color: AppColor.blackColor,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.greyColor, // your desired color
            width: 2.0, // your desired width
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor
                .greyColor, // your desired color when the TextFormField is focused
            width: 2.0, // your desired width when the TextFormField is focused
          ),
        ),
        fillColor: Colors.transparent,
        filled: true,
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),
      ),
    );
  }
}
