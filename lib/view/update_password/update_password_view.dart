import 'package:celient_project/res/animation/FadeAnimation.dart';
import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_email_widget.dart';
import 'package:celient_project/res/components/widgets/formfield/input_password_widget.dart';
import 'package:celient_project/view_model/controller/signin/signin_view_model.dart';
import 'package:celient_project/view_model/controller/update_password/update_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UpdatePasswordView extends StatelessWidget {
  const UpdatePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final updatePasswordVM = Get.put(UpdatePasswordViewModel());
    GlobalKey<FormState> updatePassFormKey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xff618a2e),
              Color(0xff82bc3c),
              Color(0xff9fe34c),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    const Text(
                      "Update Password",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    1.3,
                    const Text(
                      "Provide your old password to make the Updation",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Form(
                key: updatePassFormKey,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 60,
                          ),
                          FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(32, 132, 232, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  )
                                ],
                              ),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                    ),
                                    child: InputPasswordTextField(
                                      validator: updatePasswordVM.validate,
                                      controllerpass: updatePasswordVM
                                          .oldPasswordController.value,
                                      hintText: "Old Password",
                                      icons: const Icon(MdiIcons.lock),
                                      isPasswordType: true,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                    ),
                                    child: InputPasswordTextField(
                                      validator: updatePasswordVM.validate,
                                      controllerpass: updatePasswordVM
                                          .newPasswordController.value,
                                      hintText: "New Password",
                                      icons: const Icon(MdiIcons.lockCheck),
                                      isPasswordType: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          FadeAnimation(
                            1.6,
                            RoundButton(
                              loading: false,
                              width: 300,
                              height: Get.height * 0.06,
                              onPress: () {
                                if (updatePassFormKey.currentState!
                                    .validate()) {
                                  updatePasswordVM.updatePasswordApi();
                                  updatePasswordVM.oldPasswordController.value
                                      .clear();
                                  updatePasswordVM.newPasswordController.value
                                      .clear();
                                }
                              },
                              title: 'Update Password',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
