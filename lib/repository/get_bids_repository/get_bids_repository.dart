import 'package:celient_project/data/network/network_api_services.dart';
import 'package:celient_project/model/get_bids/get_bids_model.dart';
import 'package:celient_project/res/app_url/app_url.dart';

class GetBidsRepository {

  final _apiService = NetworkApiServices();

  Future<GetBidsModel> getBidsApi() async {
    dynamic response = await _apiService.getApi(AppUrl.getBidApi);
    return GetBidsModel.fromJson(response);
  }

}