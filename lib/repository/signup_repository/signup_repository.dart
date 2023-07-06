import 'package:celient_project/data/network/network_api_services.dart';
import 'package:celient_project/res/app_url/app_url.dart';

class SignUpRepository {

  final _apiService  = NetworkApiServices() ;


  Future<dynamic> signUpApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.signUpApi);
    return response ;
  }



}