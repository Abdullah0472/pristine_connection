import 'package:flutter/material.dart';

import '../../../colors/colors.dart';

class DropDown extends StatefulWidget {
  final Function(String?) onSelected;
  final TextEditingController dropDownController;
  final double hintSize;
  final List<String> items;
  final String selectedItem;

  const DropDown({
    Key? key,
    required this.onSelected,
    required this.dropDownController,
    this.items = const ['Polygon', 'LineString', 'Circle'],
    this.selectedItem = '',
    this.hintSize = 18,
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
      style: const TextStyle(
        color: AppColor.textColor,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      dropdownColor: AppColor.offWhite,
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
