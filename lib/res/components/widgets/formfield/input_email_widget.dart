import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view_model/controller/signin/signin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../colors/colors.dart';

// ignore: must_be_immutable
class InputEmailTextField extends StatelessWidget {
  final Icon icons;
  TextEditingController controller;
  final String? Function(String?)? validator;
  final signInVM = Get.put(SignInViewModel());
  InputEmailTextField({
    super.key,
    required this.validator,
    required this.controller,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onFieldSubmitted: (value) {
        Utils.fieldFocusChange(
          context,
          signInVM.emailFocusNode.value,
          signInVM.passwordFocusNode.value,
        );
      },
      cursorColor: Colors.grey,
      style: TextStyle(color: AppColor.blackColor,fontSize: 18,fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        prefixIcon: icons,
        prefixIconColor: AppColor.greyColor,
      //  contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: InputBorder.none,
        //fillColor: const Color.fromARGB(255, 251, 250, 249),
       fillColor: Colors.transparent,

        filled: true,
        hintText: "Email",
        hintStyle:  TextStyle(
          color: Colors.grey.shade400,
          fontSize: 18,
        ),
        //suffixIconColor: Colors.white,
        // focusedErrorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(30),
        // ),
        // disabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(30),
        //     borderSide: const BorderSide(color: AppColor.greyColor, width: 1.3)),
        // focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(
        //       30,
        //     ),
        //     borderSide: const BorderSide(color: AppColor.greyColor, width: 1.3)),
        // errorBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(30),
        //     borderSide: const BorderSide(color: AppColor.redColor, width: 1.3)),
        // enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(30),
        //     borderSide: const BorderSide(color: AppColor.greyColor, width: 1.3)),
      ),
    );
  }
}
