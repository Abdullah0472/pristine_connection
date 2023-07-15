import 'package:celient_project/data/network/network_api_services.dart';
import 'package:celient_project/res/app_url/app_url.dart';

class UploadLoadedRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> uploadUnloadData(var data) async {
    try {
      dynamic response =
      await _apiService.updateApi(data, AppUrl.uploadUnloadDataApi);
      return response;
    } catch (e) {
      print('Failed to upload loaded data: $e');
      throw Exception('Failed to upload');
    }
  }
}
