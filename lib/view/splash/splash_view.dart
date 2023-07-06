import 'package:celient_project/res/components/widgets/text/report_rich_text.dart';
import 'package:celient_project/view_model/services/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/assets/images.dart';
import '../../res/colors/colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  SplashServices splashScreen = SplashServices();

  @override
  void initState() {
    super.initState();
    splashScreen.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: SizedBox(
                height: Get.height * 0.6,
                width: Get.width * 0.6,
                child: Image.asset(ImageAssets.companyLogo),
              ),
            ),
            const Spacer(),
             const Padding(
              padding: EdgeInsets.only(bottom: 10),

              child: ReportRichText(title: 'Powered By :', des: ' Pristine Connection, LLC ',),
              // child: Text(
              //   "Powered By : Pristine Connection, LLC ",
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.bold,
              //     color: AppColor.applicationColor,
              //   ),
              // ),
            )
          ],
        ),
      ),
    );
  }
}
