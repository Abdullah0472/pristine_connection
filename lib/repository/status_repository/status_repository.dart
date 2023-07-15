
import 'package:celient_project/data/network/network_api_services.dart';
import 'package:celient_project/res/app_url/app_url.dart';

class StatusRepository {
  final _apiService = NetworkApiServices();



  Future<dynamic> tripStatus(var data) async{
    dynamic response = await _apiService.updateApi(data, AppUrl.tripStatusApi);
    return response ;
  }


}
