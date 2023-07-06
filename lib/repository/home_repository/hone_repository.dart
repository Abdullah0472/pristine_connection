import 'package:celient_project/data/network/network_api_services.dart';

class HomeRepository {
  final _apiService = NetworkApiServices();

  // Future<UserListModel> userListApi() async{
  //   dynamic response = await _apiService.getApi(AppUrl.userListApi);
  //   return UserListModel.fromJson(response) ;
  // }
}
