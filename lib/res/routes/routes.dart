import 'package:celient_project/view/bottomNavigationBar/bottomNavigationBar_view.dart';
import 'package:celient_project/view/connection/connection_view.dart';
import 'package:celient_project/view/forget_password/forget_password_view.dart';
import 'package:celient_project/view/home/home_view.dart';
import 'package:celient_project/view/profile/profile_view.dart';
import 'package:celient_project/view/signin/signin_view.dart';
import 'package:celient_project/view/splash/splash_view.dart';
import 'package:get/get.dart';
import 'routes_name.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RouteName.bottomNavBar,
      page: () => const BottomNavigationBarView(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),
        GetPage(
          name: RouteName.splashView,
          page: () => const SplashView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.signInView,
          page: () => const SignInView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.forgetPasswordView,
          page: () => const ForgetPasswordView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.homeView,
          page: () =>  HomeView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.profileView,
          page: () =>  ProfileView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),

        GetPage(
          name: RouteName.connectionView,
          page: () =>  ConnectionView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        // GetPage(
        //   name: RouteName.reportsView,
        //   page: () =>  ReportsView(),
        //   transitionDuration: const Duration(milliseconds: 250),
        //   transition: Transition.leftToRightWithFade,
        // ),

      ];
}
