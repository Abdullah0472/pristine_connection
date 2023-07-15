import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/model/start_trip/start_trip_model.dart';
import 'package:celient_project/repository/get_bids_repository/get_bids_repository.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view/home/home_view.dart';
import 'package:celient_project/view_model/controller/profile/profile_view_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StartTripController extends GetxController {
  final _api = BidsRepository();
  final profileVM = Get.put(ProfileViewModel());
  // final rxRequestStatus = Status.LOADING.obs;
  // final starttripList = StartTripModel().obs;
  // RxString error = ''.obs;

  // void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  // void setUserList(StartTripModel _value) => starttripList.value = _value;
  // void setError(String _value) => error.value = _value;
  // RefreshController refreshController = RefreshController();
  //
  // void assignBidsListApi(int? loadId) {
  //   Map<String, dynamic> data = {
  //     'load_id': loadId,
  //   };
  //   _api.startTripApi(data).then((value) {
  //     setRxRequestStatus(Status.COMPLETED);
  //     setUserList(value);
  //   }).onError((error, stackTrace) {
  //     setError(error.toString());
  //     setRxRequestStatus(Status.ERROR);
  //   });
  // }
  //
  // refreshApi(int? loadId) {
  //   Map<String, dynamic> data = {
  //     'load_id': loadId,
  //   };
  //   setRxRequestStatus(Status.LOADING);
  //   _api.startTripApi(data).then((value) {
  //     setRxRequestStatus(Status.COMPLETED);
  //     setUserList(value);
  //   }).onError((error, stackTrace) {
  //     setError(error.toString());
  //     setRxRequestStatus(Status.ERROR);
  //   });
  // }
  // //
  void startTripApi(String loadId) async {
    try {
      Map<String, dynamic> data = {
        'load_id': loadId,
      };
      StartTripModel response = await _api.startTripApi(data);
      if (response.statusCode == 200) {
        if (response.data![0].status == 'started') {
          Utils.snackBar('Trip Started', 'Successfully');
          Get.to(HomeView(
            // loadId: response.data![0].loadId,
            // pickUpDateTime: response.data![0].pickupDate,
            // pieces: response.data![0].pieces,
            // dims: response.data![0].dims,
            // weight: response.data![0].weight.toString(),
            // pickupName:  profileVM.userList.value.data?.name,
            // miles:  response.data![0].miles.toString(),
            // pickUpLocation:  response.data![0].pickupLocation,
            // deliveryAddress:  response.data![0].deliveryLocation,
            // deliveryDateTime:  response.data![0].deliveryDate,
            // status:  response.data![0].status,

          ));
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
