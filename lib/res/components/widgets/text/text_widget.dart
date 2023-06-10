import 'package:flutter/material.dart';

import '../../../colors/colors.dart';

Text customText(String text, bool mainColor, {double size = 17}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w500,
        color: mainColor == true ? AppColor.greyColor : AppColor.whiteColor),
  );
}
