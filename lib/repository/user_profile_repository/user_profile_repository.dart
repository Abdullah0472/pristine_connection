import 'package:celient_project/data/network/network_api_services.dart';
import 'package:celient_project/model/user/user_model.dart';
import 'package:celient_project/res/app_url/app_url.dart';

class UserProfileRepository {

  final _apiService = NetworkApiServices();

  Future<UserModel> userListApi() async{
    dynamic response = await _apiService.getApi(AppUrl.userProfileApi);
    return UserModel.fromJson(response) ;
  }


  Future<dynamic> updateUser(var data) async{
    dynamic response = await _apiService.updateApi(data, AppUrl.updateUserProfileApi);
    return response ;
  }

  // Future<dynamic> updateImageUser(var data) async{
  //   dynamic response = await _apiService.updateApi(data, AppUrl.updateImageApi);
  //   return response ;
  // }

  Future<dynamic> updateImageUser(var data) async {
    try {
      dynamic response = await _apiService.updateApi(data, AppUrl.updateImageApi);
      return response;
    } catch (e) {
      print('Failed to update image: $e');
      throw Exception('Failed to update image');
    }
  }


}
