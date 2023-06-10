import 'package:flutter/material.dart';

import '../../../colors/colors.dart';

class ReportsDropDown extends StatefulWidget {
  final Function(String?) onSelected;
  final TextEditingController dropDownController;
  final double hintSize;
  final String dropDownvalue;
  final List<String> item;

  const ReportsDropDown({
    Key? key,
    required this.onSelected,
    required this.item,
    this.dropDownvalue = "Today",
    required this.dropDownController,
    this.hintSize = 18,
  }) : super(key: key);

  @override
  State<ReportsDropDown> createState() => _ReportsDropDownState();
}

class _ReportsDropDownState extends State<ReportsDropDown> {
  @override
  void initState() {
    super.initState();
    widget.dropDownController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    String selectedValue = widget.dropDownvalue;
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
      style: const TextStyle(
          color: AppColor.textColor,
          fontSize: 18,
          fontWeight: FontWeight.w400), // update text color to black
      dropdownColor: AppColor.offWhite, // update dropdown menu color to white
      iconEnabledColor: Colors.grey.shade400,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColor.greyColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColor.greyColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Colors.transparent,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColor.redColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColor.greyColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      value: selectedValue,
      items: widget.item.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
          // widget.dropDownController.text = selectedValue;
        });
        widget.onSelected(selectedValue);
      },
      onSaved: (value) {
        widget.dropDownController.text = value ?? '';
      },
    );
  }
}
