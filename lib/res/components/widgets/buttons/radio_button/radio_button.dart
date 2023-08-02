import 'package:celient_project/res/assets/images.dart';
import 'package:celient_project/view_model/controller/signup/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyRadioButtons extends StatefulWidget {
  final Function(String?) onSelected;
  final TextEditingController radioController;

  const MyRadioButtons(
      {Key? key, required this.onSelected, required this.radioController})
      : super(key: key);

  @override
  State<MyRadioButtons> createState() => _MyRadioButtonsState();
}

// class _MyRadioButtonsState extends State<MyRadioButtons> {
//   final signUpVM = Get.put(SignUpViewModel());
//
//
//   final items = ['Yes', 'No'];
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Row(
//         children: items.map((item) {
//           Image icon;
//           if (item == 'Yes') {
//             icon = Image.asset(ImageAssets.tick,width: 20,height: 20,);
//           } else if (item == 'No') {
//             icon = Image.asset(ImageAssets.cross,width: 20,height: 20,);
//           } else {
//             icon = Image.asset('');
//           }
//
//           return
//           Row(children: [
//             Radio<String>(
//               value: item,
//               groupValue: signUpVM.groupValue,
//               onChanged: (value) {
//                 setState(() {
//                   signUpVM.groupValue = value!;
//                   widget.radioController.text = signUpVM.groupValue!;
//                 });
//                 widget.onSelected(signUpVM.groupValue);
//               },
//             ),
//             icon,
//           ],);
//         }).toList(),
//       ),
//     );
//   }
// }

class _MyRadioButtonsState extends State<MyRadioButtons> {

  final signUpVM = SignUpViewModel();

  final items = ['yes', 'no'];

  @override
  void initState() {
    super.initState();
    signUpVM.groupValue.value = 'no'; // Set the default value to 'No'
    widget.radioController.text = signUpVM.groupValue.value;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: items.map((item) {
          Image icon;
          if (item == 'yes') {
            icon = Image.asset(
              ImageAssets.tick,
              width: 20,
              height: 20,
            );
          } else if (item == 'no') {
            icon = Image.asset(
              ImageAssets.cross,
              width: 20,
              height: 20,
            );
          } else {
            icon = Image.asset('');
          }

          return Row(
            children: [
              Obx(() => Radio<String>(
                value: item,
                groupValue: signUpVM.groupValue.value,
                onChanged: (value) {
                  signUpVM.groupValue.value = value!;
                  widget.radioController.text = signUpVM.groupValue.value;
                  widget.onSelected(signUpVM.groupValue.value);
                },
              )),
              icon,
            ],
          );
        }).toList(),
      ),
    );
  }
}
