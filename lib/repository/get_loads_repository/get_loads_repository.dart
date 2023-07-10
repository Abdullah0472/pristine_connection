import 'package:celient_project/data/network/network_api_services.dart';
import 'package:celient_project/model/loads/loads_model.dart';
import 'package:celient_project/res/app_url/app_url.dart';

class LoadsRepository {
  final _apiService = NetworkApiServices();

  Future<LoadsModel> loadsApi(Map<String, dynamic> data) async {
    dynamic response = await _apiService.updateApi(data, AppUrl.loadsApi);
    return LoadsModel.fromJson(response);
  }

  Future<dynamic> makeBid(var data) async{
    dynamic response = await _apiService.updateApi(data, AppUrl.makeBidApi);
    return response ;
  }


}
