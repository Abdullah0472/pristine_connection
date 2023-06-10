import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../res/colors/colors.dart';
class Utils {


    static void fieldFocusChange(BuildContext context , FocusNode current , FocusNode  nextFocus ){
      current.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
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