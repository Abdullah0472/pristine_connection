import 'package:celient_project/model/login/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  Future<bool> saveUser(LoginModel responseModel) async {
    print('Saving user...');

    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setString('token', responseModel.data!.bearerToken ?? '');
    sp.setString('uniqueId', responseModel.data!.uniqueId ?? '');
    sp.setBool('isLogin', responseModel.isLogin ?? false);
    print('User saved.');
    return true;
  }


  Future<LoginModel> getUser() async {
    print('Getting user...');
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    String? uniqueId = sp.getString('uniqueId');
    bool? isLogin = sp.getBool('isLogin');
    print('User got.');
    return LoginModel(
      data: Data(bearerToken: token,uniqueId:uniqueId ),
      isLogin: isLogin,
    );
  }

  Future<bool> removeUser() async {
    print('Removing user...');
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    print('User removed.');
    return true;
  }
}
