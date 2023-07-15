import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/model/assign_bids/assign_bids_model.dart';
import 'package:celient_project/model/get_bids/get_bids_model.dart';
import 'package:celient_project/model/start_trip/start_trip_model.dart';
import 'package:celient_project/repository/get_bids_repository/get_bids_repository.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view/home/home_view.dart';
import 'package:celient_project/view_model/controller/profile/profile_view_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AssignBidsController extends GetxController {
  final _api = BidsRepository();
  final profileVM = Get.put(ProfileViewModel());
  final rxRequestStatus = Status.LOADING.obs;
  final assignbidsList = AssignBidsModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setUserList(AssignBidsModel _value) => assignbidsList.value = _value;
  void setError(String _value) => error.value = _value;
  RefreshController refreshController = RefreshController();

  void assignBidsListApi() {
    _api.getAssignBidsApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAssignBidsApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

}
