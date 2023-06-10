import 'package:flutter/material.dart';

import '../../../colors/colors.dart';

class ReportRichText extends StatelessWidget {
  final String title;
  final String des;
  const ReportRichText({Key? key, required this.title, required this.des}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: RichText(
        text:  TextSpan(
            text: title,
            style: const TextStyle(
                color: AppColor.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
            children: <TextSpan>[
              TextSpan(
                text: des,
                style: const TextStyle(
                    color: AppColor.applicationColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ]),
      ),
    );
  }
}
