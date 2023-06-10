import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../colors/colors.dart';

class PieChartText extends StatelessWidget {
  final double top;
  final double right;
  final double angle;
  final double left;
  final double bottom;
  final String title;
  final String number;
  const PieChartText(
      {Key? key,
      this.top = 0,
      this.right = 0,
      this.left = 0,
      this.bottom = 0,
      required this.angle,
      required this.title,
      required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      left: left,
      bottom: bottom,
      child: Transform.rotate(
        angle: math.pi / angle,
        child: RichText(
          text: TextSpan(
              text: '$title ',
              style: const TextStyle(
                  color: AppColor.darkerColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
              children: <TextSpan>[
                TextSpan(
                  text: ' $number',
                  style: const TextStyle(
                      color: AppColor.darkerColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )
              ]),
        ),
      ),
    );
  }
}
