import 'package:flutter/material.dart';

import '../../../colors/colors.dart';

class DropDown extends StatefulWidget {
  final Function(String?) onSelected;
  final TextEditingController dropDownController;
  final double hintSize;
  List<String> items;
  final String selectedItem;
  final String hintText;

   DropDown({
    Key? key,
    required this.onSelected,
    required this.dropDownController,
    this.items = const ['yes', 'no',],
    this.selectedItem = '',
    this.hintSize = 18,
     required this.hintText,
  }) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? dropdownValue;


  @override
  void initState() {
    super.initState();
    dropdownValue = widget.selectedItem;
    widget.dropDownController.text = dropdownValue ?? '';
  }



  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text(
        'Select Condition',
        style: TextStyle(
          color: Colors.grey.shade400,
          fontSize: widget.hintSize,
        ),
      ),
      validator: (value) =>
      value == null || value.isEmpty ? 'Please select a value' : null,
      style: TextStyle(color: AppColor.blackColor,fontSize: 16,fontWeight: FontWeight.w400),
      dropdownColor: AppColor.offWhite,
      iconEnabledColor: Colors.grey.shade400,
      decoration: InputDecoration(

     //   prefixIcon: Icon(icons,color: AppColor.darkerColor),
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
      value: dropdownValue,
      items: widget.items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          dropdownValue = value;
          widget.dropDownController.text = dropdownValue ?? '';
        });
        widget.onSelected(dropdownValue);
      },
      onSaved: (value) {
        widget.dropDownController.text = value ?? '';
      },
    );
  }
}
