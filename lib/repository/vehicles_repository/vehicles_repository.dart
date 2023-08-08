import 'package:celient_project/data/network/network_api_services.dart';
import 'package:celient_project/model/vehicles/vehicles_model.dart';

import 'package:celient_project/res/app_url/app_url.dart';

class VehicleRepository {

  final _apiService = NetworkApiServices();

  Future<VehiclesModel> getVehicleApi() async {
    dynamic response = await _apiService.getApi(AppUrl.getVehiclesDataApi);
    return VehiclesModel.fromJson(response);
  }

  Future<dynamic> uploadVehicleData(var data) async {
    try {
      dynamic response =
      await _apiService.updateApi(data, AppUrl.addVehiclesDataApi);
      return response;
    }
    catch (e) {
      print('Failed to Add Vehicle data: $e');
      throw Exception('Failed to upload');
    }
  }

  ///========================= AssignBidsApi ================== ///
  // Future<AssignBidsModel> getAssignBidsApi() async {
  //   dynamic response = await _apiService.getApi(AppUrl.assignBidApi);
  //   return AssignBidsModel.fromJson(response);
  // }

  // Future<StartTripModel> startTripApi(Map<String, dynamic> data) async {
  //   dynamic response = await _apiService.updateApi(data, AppUrl.startTripApi);
  //   return StartTripModel.fromJson(response);
  // }


}