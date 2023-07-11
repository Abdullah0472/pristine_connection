import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/model/get_bids/get_bids_model.dart';
import 'package:celient_project/repository/get_bids_repository/get_bids_repository.dart';
import 'package:get/get.dart';

class GetBidsController extends GetxController {
  final _api = GetBidsRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final bidsList = GetBidsModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setUserList(GetBidsModel _value) => bidsList.value = _value;
  void setError(String _value) => error.value = _value;

  void bidsListApi() {
    _api.getBidsApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getBidsApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}
