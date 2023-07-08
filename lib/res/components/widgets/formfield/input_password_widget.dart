import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view_model/controller/signin/signin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../colors/colors.dart';

// ignore: must_be_immutable
class InputPasswordTextField extends StatefulWidget {
  final Icon icons;
  bool isPasswordType;
  final TextEditingController controllerpass;
  final String hintText;
  final String? Function(String?)? validator;
  InputPasswordTextField(
      {Key? key,
      required this.isPasswordType,
      required this.controllerpass,
      this.validator,
        this.hintText = "Password",
      required this.icons})
      : super(key: key);

  @override
  State<InputPasswordTextField> createState() => _InputPasswordTextFieldState();
}

class _InputPasswordTextFieldState extends State<InputPasswordTextField> {
  final signInVM = Get.put(SignInViewModel());
  void inContact(TapDownDetails details) {
    setState(() {
      widget.isPasswordType = false;
    });
  }

  void outContact(TapUpDetails details) {
    setState(() {
      widget.isPasswordType = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (value) {
        Utils.fieldFocusChange(context, signInVM.emailFocusNode.value,
            signInVM.passwordFocusNode.value);
      },
      style:  TextStyle(
          color: AppColor.blackColor,
          fontSize: 18,
          fontWeight: FontWeight.w400),
      controller: widget.controllerpass,
      obscureText: widget.isPasswordType,
      obscuringCharacter: "*",
      enableSuggestions: widget.isPasswordType,
      autocorrect: widget.isPasswordType,
      cursorColor: Colors.grey,
      minLines: 1,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 18,
        ),
        prefixIcon: widget.icons,
        prefixIconColor: AppColor.greyColor,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        // contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: InputBorder.none,
        fillColor: Colors.transparent,

        suffixIcon:

            GestureDetector(
          onTapDown: inContact,
          onTapUp: outContact,
          child: const Icon(
            Icons.remove_red_eye,
            color: AppColor.greyColor,
          ),
        ),
        //   ),
      ),
      keyboardType: widget.isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      validator: widget.validator,
    );
  }
}
