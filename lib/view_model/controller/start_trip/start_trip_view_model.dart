import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/model/start_trip/start_trip_model.dart';
import 'package:celient_project/repository/get_bids_repository/get_bids_repository.dart';
import 'package:celient_project/res/routes/routes_name.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view/home/home_view.dart';
import 'package:celient_project/view_model/controller/profile/profile_view_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StartTripController extends GetxController {
  final _api = BidsRepository();
  final profileVM = Get.put(ProfileViewModel());
  void startTripApi(String loadId) async {
    try {
      Map<String, dynamic> data = {
        'load_id': loadId,
      };
      StartTripModel response = await _api.startTripApi(data);
      if (response.statusCode == 200) {
        if (response.data![0].status == 'started') {
          Utils.snackBar('Trip Started', 'Successfully');
          Get.toNamed(RouteName.bottomNavBar);

        } else {
          Utils.snackBar('Trip is already Started', 'UnSuccessful to Start');
        }
      } else if (response.statusCode == 400) {
        Utils.snackBar('Trip Started', 'UnSuccessfully');
      } else {
        Utils.snackBar(
            'Error', response.error ?? 'An error occurred while starting trip');
      }
    } catch (e) {
      Utils.snackBar('Failed to Start Trip',
          'An unexpected error occurred while starting trip');
      print("Unexpected error while starting trip = ${e.toString()}");
    }
  }
}
