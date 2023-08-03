import 'package:celient_project/repository/status_repository/status_repository.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:celient_project/view/load_info/load_info_view.dart';
import 'package:celient_project/view/unloaded/unloaded_view.dart';
import 'package:celient_project/view_model/controller/button/button_view_model.dart';
import 'package:celient_project/view_model/controller/current_trip/current_trip_view_model.dart';
import 'package:celient_project/view_model/controller/load_status_view_model/load_status_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripStatusViewModel extends GetxController {
  final _api = StatusRepository();
  final ButtonController buttonController = Get.put(ButtonController());
  LoadStatusPreference loadStatuses = LoadStatusPreference();
  final currentTripVM = Get.put(CurrentTripController());

  void tripStatusApi(String loadId, String status, String piece,
      String totalWeight, String deliverAddress) async {
    try {
      Map data = {
        'load_id': loadId,
        'status': status,
      };
      _api.tripStatus(data).then((value) {
        if (value['status_code'] == 200) {
          Utils.snackBar("Status Changed", "Successfully");

          buttonController.buildUpdatedButton(() {
            Get.to(
              () => LoadInfoView(
                loadId: loadId,
                piece: piece,
                totalWeight: totalWeight,
                deliverAddress: deliverAddress,
              ),
            );

            Get.back();
          });
        } else {
          Utils.snackBar('Error', 'Unknown error occurred');
        }
      }).onError((error, stackTrace) {
        Utils.snackBar('Error', error.toString());
      });
    } catch (e) {
      Utils.snackBar(
          'Password Updated', 'An error occurred while password update');
      // Add logic here to display activity indicator and navigate back after 2 seconds

      return; // End the function
    }
  }

  /// =========================== Trip Delivery Status ==================== ///

  void tripDeliveryStatusApi(String loadId, String status, String piece,
      String totalWeight, String deliverAddress) async {
    try {
      Map data = {
        'load_id': loadId,
        'status': status,
      };
      _api.tripStatus(data).then((value) async {
        if (value['status_code'] == 200) {
          Utils.snackBar("Status Changed", "Successfully");

       //  await currentTripVM.currentTripListApi();
       //    loadStatuses
       //        .saveLoadStatus('customer')
       //        .then((value) {
       //      // You could do something here after saving, or simply do nothing
       //    })
       //        .onError((error, stackTrace) {
       //      // Log or handle error here
       //      // setError(error.toString());
       //    });

          buttonController.buildUnloadButton(() {
            Get.to(() => UnloadedView(loadId: loadId,));
            Get.back();
          });
        } else {
          Utils.snackBar('Error', 'Unknown error occurred');
        }
      }).onError((error, stackTrace) {
        Utils.snackBar('Error', error.toString());
      });
    } catch (e) {
      Utils.snackBar(
          'Password Updated', 'An error occurred while password update');
      // Add logic here to display activity indicator and navigate back after 2 seconds

      return; // End the function
    }
  }
}
