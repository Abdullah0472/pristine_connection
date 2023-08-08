import 'package:flutter/material.dart';
import '../../../colors/colors.dart';

class CardButton extends StatelessWidget {
  const CardButton(
      {Key? key,
        this.buttonColor = AppColor.applicationColor,
        this.textColor = AppColor.whiteColor,
        required this.title,
        required this.onPress,
        this.width = 60,
        this.height = 50,

      })
      : super(key: key);

  final String title;
  final double height, width;
  final VoidCallback onPress;
  final Color textColor, buttonColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
           border: Border.all(color: AppColor.textColor,width: 2),
            color: buttonColor,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 22,

            ),
          ),
        ),
      ),
    );
  }
}
