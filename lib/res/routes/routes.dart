import 'package:celient_project/view/all_job/all_job_view.dart';
import 'package:celient_project/view/bottomNavigationBar/bottomNavigationBar_view.dart';
import 'package:celient_project/view/forget_password/forget_password_view.dart';
import 'package:celient_project/view/history/history_view.dart';
import 'package:celient_project/view/home/home_view.dart';
import 'package:celient_project/view/profile/profile_view.dart';
import 'package:celient_project/view/signin/signin_view.dart';
import 'package:celient_project/view/signup_view/signup_view.dart';
import 'package:celient_project/view/splash/splash_view.dart';
import 'package:celient_project/view/unloaded/unloaded_view.dart';
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
      name: RouteName.signUpView,
      page: () => const SignUpView(),
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
          page: () =>  HistoryView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
    GetPage(
      name: RouteName.unloadedView,
      page: () =>  UnloadedView(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: RouteName.allJobVIew,
      page: () =>  AllJobView(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),

      ];
}
