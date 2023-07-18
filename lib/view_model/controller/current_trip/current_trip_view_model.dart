import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/model/current_trip/current_trip_model.dart';
import 'package:celient_project/repository/current_trip_repository/current_trip_repository.dart';
import 'package:celient_project/view_model/controller/load_status_view_model/load_status_view_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// class CurrentTripController extends GetxController {
//   final _api = CurrentTripRepository();
//   final rxRequestStatus = Status.LOADING.obs;
//   final currentTripList = CurrentTripModel().obs;
//   RxString error = ''.obs;
//   LoadStatusPreference loadStatuses = LoadStatusPreference();
//   void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
//   void setUserList(CurrentTripModel _value) => currentTripList.value = _value;
//   void setError(String _value) => error.value = _value;
//   RefreshController refreshController = RefreshController();
//    currentTripListApi() {
//     //  setRxRequestStatus(Status.LOADING);
//      loadingStatus();
//     _api.getCurrentTripApi().then((value) {
//       setRxRequestStatus(Status.COMPLETED);
//       setUserList(value);
//     }).onError((error, stackTrace) {
//       setError(error.toString());
//       setRxRequestStatus(Status.ERROR);
//     });
//   }
//
//   refreshApi() {
//     setRxRequestStatus(Status.LOADING);
//     _api.getCurrentTripApi().then((value) {
//       setRxRequestStatus(Status.COMPLETED);
//       setUserList(value);
//     }).onError((error, stackTrace) {
//       setError(error.toString());
//       setRxRequestStatus(Status.ERROR);
//     });
//   }
//   void loadingStatus() async {
//     try {
//       _api.getCurrentTripApi().then((value) {
//         if (value.statusCode == 200) {
//           String loadStatus = value.data![0].loadStatus ?? '';
//           loadStatuses.saveLoadStatus(loadStatus).then((value) {
//             // You could do something here after saving, or simply do nothing
//           }).onError((error, stackTrace) {
//             // Log or handle error here
//             setError(error.toString());
//           });
//         } else if (value.statusCode == 400) {
//           // Handle 400 status here
//           setError("Bad request"); // This is just an example
//         } else {
//           // Handle other statuses here
//           setError("Unknown error"); // This is just an example
//         }
//       }).onError((error, stackTrace) {
//         // Log or handle error here
//         setError(error.toString());
//       });
//     } catch (e) {
//       // Log or handle error here
//       setError(e.toString());
//     }
//   }
//
// }


/// Without shared prefernce
///
class CurrentTripController extends GetxController {
  final _api = CurrentTripRepository();
  final rxRequestStatus = Status.LOADING.obs;
  final currentTripList = CurrentTripModel().obs;
  RxString error = ''.obs;
  final LoadStatusPreference loadStatuses = LoadStatusPreference();

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setUserList(CurrentTripModel _value) => currentTripList.value = _value;
  void setError(String _value) => error.value = _value;
  RefreshController refreshHomeController = RefreshController();

   currentTripListApi() {
    loadingStatus();
    _api.getCurrentTripApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setUserList(value);
      updateLoadStatus(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

   refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getCurrentTripApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setUserList(value);
      updateLoadStatus(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void loadingStatus() {
    _api.getCurrentTripApi().then((value) {
      updateLoadStatus(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
    });
  }

  void updateLoadStatus(CurrentTripModel currentTripModel) {
    if (currentTripModel.data != null && currentTripModel.data!.isNotEmpty) {
      String loadStatus = currentTripModel.data![0].loadStatus ?? '';
      loadStatus = loadStatus.toLowerCase(); // Convert to lowercase for consistent comparison
      loadStatuses.saveLoadStatus(loadStatus);
    }
  }
}
