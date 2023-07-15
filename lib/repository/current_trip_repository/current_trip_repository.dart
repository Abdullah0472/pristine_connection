import 'package:celient_project/data/network/network_api_services.dart';
import 'package:celient_project/model/current_trip/current_trip_model.dart';
import 'package:celient_project/res/app_url/app_url.dart';

class CurrentTripRepository {
  final _apiService = NetworkApiServices();

  Future<CurrentTripModel> getCurrentTripApi() async {
    dynamic response = await _apiService.getApi(AppUrl.currentTripApi);
    return CurrentTripModel.fromJson(response);
  }

}