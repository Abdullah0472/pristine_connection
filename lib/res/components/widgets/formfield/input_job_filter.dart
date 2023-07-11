import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view_model/controller/all_jobs/all_jobs_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../colors/colors.dart';

// ignore: must_be_immutable
class InputJobFilterTextField extends StatelessWidget {
  TextEditingController controller;
  final String hint;
  final bool number;
  final AllJobViewModel allJobVM;
  final String initialValue; // add this line

  InputJobFilterTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.initialValue = '',
    this.number = true,
  }) : allJobVM = Get.put(AllJobViewModel()), super(key: key) {
    controller.text = initialValue; // set initial value to controller here
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: number ? TextInputType.phone : TextInputType.name,
      controller: controller,
      onFieldSubmitted: (value) {
        Utils.fieldFocusAllJob(
          context,
          allJobVM.radiusFocusNode.value,
          allJobVM.postalCodeFocusNode.value,
          allJobVM.bidFocusNode.value,
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
            color: AppColor.greyColor,
            width: 2.0,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.greyColor,
            width: 2.0,
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
