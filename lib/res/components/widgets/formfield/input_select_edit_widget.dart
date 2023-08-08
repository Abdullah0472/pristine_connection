import 'package:celient_project/res/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InputDateEditSelectionTextField extends StatefulWidget {
  TextEditingController controller;
  final String hintText;
  final String initialValue; // add this line
  InputDateEditSelectionTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.initialValue = '',
  }): super(key: key) {
    controller.text = initialValue; // set initial value to controller here
  }

  @override
  State<InputDateEditSelectionTextField> createState() =>
      _InputDateEditSelectionTextFieldState();
}

class _InputDateEditSelectionTextFieldState
    extends State<InputDateEditSelectionTextField> {
  @override
  void initState() {
    widget.controller.text = widget.initialValue; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      cursorColor: Colors.grey,
      style: TextStyle(color: AppColor.blackColor,fontSize: 16,fontWeight: FontWeight.w400), //editing controller of this TextField
      decoration: InputDecoration(

        prefixIcon: Icon(MdiIcons.calendar,color: AppColor.darkerColor),
        contentPadding: const EdgeInsets.symmetric(vertical: 18,horizontal: 20),
        border: InputBorder.none,
        // fillColor: const Color.fromARGB(255, 251, 250, 249),
        // filled: true,
        suffixIconColor: Colors.grey,


        //fillColor: const Color.fromARGB(255, 251, 250, 249),
        fillColor: Colors.transparent,

        filled: true,

        labelText: widget.hintText,
        labelStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 17,
        ),
        hintText: widget.hintText,
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
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          // print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          //  print(formattedDate); //formatted date output using intl package =>  2021-03-16
          //you can implement different kind of Date Format here according to your requirement

          setState(() {
            widget.controller.text =
                formattedDate; //set output date to TextField value.
          });
        } else {
          print("Date is not selected");
        }
      },
    );
  }
}
