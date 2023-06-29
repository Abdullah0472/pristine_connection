import 'package:celient_project/res/colors/colors.dart';
import 'package:flutter/material.dart';

class ImagePicker extends StatelessWidget {
  final String unloadingImage;

  const ImagePicker(this.unloadingImage, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        offset: const Offset(
                          1.0,
                          1.0,
                        ),
                      )
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    color: Colors.transparent, // Replace with your color
                  ),
                  // width: double.infinity,
                  // height: double.infinity,
                  child: Image.asset(unloadingImage, ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3.0,
              spreadRadius: 3.0,
              offset: const Offset(
                1.0,
                1.0,
              ),
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: Colors.transparent, // Replace with your color
        ),
        width: 300,
        child: Image.asset(unloadingImage),
      ),
    );
  }
}
