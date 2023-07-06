import 'dart:async';

import 'package:celient_project/res/routes/routes_name.dart';
import 'package:celient_project/view_model/controller/user_preference/user_prefrence_view_model.dart';
import 'package:get/get.dart';

// class SplashServices {
//   UserPreference userPreference = UserPreference();
//
//   void isLogin() {
//     userPreference.getUser().then((value) {
//       print(value.token);
//       print(value.isLogin);
//
//       if (value.isLogin == false || value.isLogin.toString() == 'null') {
//         Timer(const Duration(seconds: 3),
//             () => Get.toNamed(RouteName.signInView));
//       } else {
//         Timer(const Duration(seconds: 3),
//             () => Get.toNamed(RouteName.bottomNavBar));
//       }
//     });
//   }
// }

class SplashServices {
  UserPreference userPreference = UserPreference();

  void isLogin() {
    userPreference.getUser().then((value) {
      print(value.data?.bearerToken);
      print(value.isLogin);

      if (value.isLogin == false || value.isLogin == null) {
        Timer(const Duration(seconds: 3), () => Get.toNamed(RouteName.signInView));
      } else {
        Timer(const Duration(seconds: 3), () => Get.toNamed(RouteName.bottomNavBar));
      }
    });
  }
}
