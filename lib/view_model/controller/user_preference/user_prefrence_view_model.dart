import 'package:celient_project/model/login/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class UserPreference {
//
//     Future<bool> saveUser(UserModel responseModel)async{
//       SharedPreferences sp = await SharedPreferences.getInstance();
//       sp.setString('token', responseModel.token.toString());
//       sp.setBool('isLogin', responseModel.isLogin!);
//
//       return true ;
//     }
//
//     Future<UserModel> getUser()async{
//       SharedPreferences sp = await SharedPreferences.getInstance();
//       String? token = sp.getString('token');
//       bool? isLogin = sp.getBool('isLogin');
//
//       return UserModel(
//         token: token ,
//         isLogin: isLogin
//       ) ;
//     }
//
//     Future<bool> removeUser()async{
//       SharedPreferences sp = await SharedPreferences.getInstance();
//       sp.clear();
//       return true ;
//     }
// }

class UserPreference {
  Future<bool> saveUser(UserModel responseModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', responseModel.data!.bearerToken ?? '');
    sp.setBool('isLogin', responseModel.isLogin ?? false);

    return true;
  }

  Future<UserModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    bool? isLogin = sp.getBool('isLogin');

    return UserModel(
      data: Data(bearerToken: token),
      isLogin: isLogin,
    );
  }

  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }
}
