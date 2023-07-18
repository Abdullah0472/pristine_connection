import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/model/get_bids/get_bids_model.dart';
import 'package:celient_project/repository/get_bids_repository/get_bids_repository.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GetBidsController extends GetxController {
  final _api = BidsRepository();
  RefreshController refreshPendingBidsController = RefreshController();
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

   refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getBidsApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void cancelBidApi(String bidId) async {
    try {
      Map<String, dynamic> data = {
        'bid_id': bidId,
      };

      Map<String, dynamic> response = await _api.cancelBid(data);

      if (response != null && response['status_code'] == 200) {
        Utils.snackBar('Bid Cancelled', 'Successfully');
      } else {
        Utils.snackBar('Error', response['error'] ?? 'An error occurred while cancelling bid');
      }
    } catch (e) {
      Utils.snackBar('Failed to Cancel Bid', 'An unexpected error occurred while cancelling bid');
      print("Unexpected error while cancelling bid = ${e.toString()}");
    }
  }

}
