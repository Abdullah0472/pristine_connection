import 'package:celient_project/data/network/network_api_services.dart';
import 'package:celient_project/res/app_url/app_url.dart';

class UpdatePasswordRepository {

  final _apiService  = NetworkApiServices() ;


  Future<dynamic> updatePasswordApi(var data) async{
    dynamic response = await _apiService.updateApi(data, AppUrl.updatePasswordApi);
    return response ;
  }



}