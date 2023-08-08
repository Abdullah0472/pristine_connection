import 'package:celient_project/res/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InputDateSelectionTextField extends StatefulWidget {
  TextEditingController controller;
  final String hintText;

  InputDateSelectionTextField({
    Key? key,
    required this.controller,
    required this.hintText,

  }): super(key: key) {
    // set initial value to controller here
  }

  @override
  State<InputDateSelectionTextField> createState() =>
      _InputDateSelectionTextFieldState();
}

class _InputDateSelectionTextFieldState
    extends State<InputDateSelectionTextField> {
  @override
  void initState() {
    widget.controller.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      cursorColor: Colors.grey,
      style: TextStyle(
          color: AppColor.blackColor,
          fontSize: 18,
          fontWeight: FontWeight.w400), //editing controller of this TextField
      decoration: InputDecoration(
        prefixIcon: Icon(MdiIcons.calendar), //icon of text field
        // labelText: "Enter Date", //label text of field

        prefixIconColor: AppColor.greyColor,
        //  contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: InputBorder.none,
        //fillColor: const Color.fromARGB(255, 251, 250, 249),
        fillColor: Colors.transparent,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 18,
        ),
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
