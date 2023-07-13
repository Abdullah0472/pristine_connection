import 'package:celient_project/data/network/network_api_services.dart';
import 'package:celient_project/model/assign_bids/assign_bids_model.dart';
import 'package:celient_project/model/get_bids/get_bids_model.dart';
import 'package:celient_project/res/app_url/app_url.dart';

class BidsRepository {

  final _apiService = NetworkApiServices();

  Future<GetBidsModel> getBidsApi() async {
    dynamic response = await _apiService.getApi(AppUrl.getBidApi);
    return GetBidsModel.fromJson(response);
  }


  Future<dynamic> cancelBid(var data) async{
    dynamic response = await _apiService.updateApi(data, AppUrl.cancelBidApi);
    return response ;
  }

 ///========================= AssignBidsApi ================== ///
  Future<AssignBidsModel> getAssignBidsApi() async {
    dynamic response = await _apiService.getApi(AppUrl.assignBidApi);
    return AssignBidsModel.fromJson(response);
  }


  // Future<dynamic> startBid(var data) async{
  //   dynamic response = await _apiService.updateApi(data, AppUrl.cancelBidApi);
  //   return response ;
  // }


}