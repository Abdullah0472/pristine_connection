import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../res/colors/colors.dart';
class Utils {


    static void fieldFocusChange(BuildContext context , FocusNode current , FocusNode  nextFocus ){
      current.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }

    static void fieldFocusReviewChange(
        BuildContext context,
        FocusNode current,
        FocusNode nextFocus,
        FocusNode licence,
        FocusNode truckNumber,

        ) {
      current.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }

    static void fieldInfoDetailChange(
        BuildContext context,
        FocusNode piece,
        FocusNode totalWeight,
        FocusNode bolNumber,
        FocusNode unloadBy,

        ) {
      piece.unfocus();
      FocusScope.of(context).requestFocus(totalWeight);
    }


    static toastMessage(String message){
      Fluttertoast.showToast(
          msg: message ,
        backgroundColor: AppColor.redColor ,
        textColor: AppColor.whiteColor,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,


      );
    }


    static toastMessageCenter(String message){
      Fluttertoast.showToast(
        msg: message ,
        backgroundColor: AppColor.redColor ,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG,
        textColor: AppColor.whiteColor,
      );
    }

    static snackBar(String title, String message){
      Get.snackbar(
          title,
          message ,
      );
    }
}