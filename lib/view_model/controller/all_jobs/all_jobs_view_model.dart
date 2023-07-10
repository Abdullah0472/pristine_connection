
import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/model/loads/loads_model.dart';
import 'package:celient_project/repository/get_loads_repository/get_loads_repository.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AllJobViewModel extends GetxController {
  final radiusController = TextEditingController().obs;
  final postalCodeController = TextEditingController().obs;
  final bidController = TextEditingController().obs;
  final messageController = TextEditingController().obs;
  final vehicleTypeController = TextEditingController().obs;

  RxString price = '0'.obs;

  void updatePrice(String newPrice) {
    price.value = newPrice;
  }

  final radiusFocusNode = FocusNode().obs;
  final postalCodeFocusNode = FocusNode().obs;
  final bidFocusNode = FocusNode().obs;
  final messageFocusNode = FocusNode().obs;
  final vehicleTypeFocusNode = FocusNode().obs;

  late DateTime now;
  late int daysInMonth;
  late DateTime day;

  final _api = LoadsRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final loadsList = LoadsModel().obs;
  RxString error = ''.obs;

  /// =================== Date Selection ================== ///
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  void selectDate(DateTime date) {
    selectedDate.value = date;
    userListApi(); // make a network call when a date is selected
  }

  bool get isDateSelected => selectedDate.value != null;

  String? get selectedMonth {
    if (isDateSelected) {
      return DateFormat('MMMM').format(selectedDate.value!);
    } else {
      return null;
    }
  }

  String? get selectedDayDate {
    if (isDateSelected) {
      return selectedDate.value!.day.toString();
    } else {
      return null;
    }
  }

  String? get selectedYear {
    if (isDateSelected) {
      return selectedDate.value!.year.toString();
    } else {
      return null;
    }
  }

  String? get selectedDay {
    if (isDateSelected) {
      // Use 'EEEE' format to get day of the week
      return DateFormat('EEEE').format(selectedDate.value!);
    } else {
      return null;
    }
  }

  /// =================== Date Selection ================== ///

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setUserList(LoadsModel _value) => loadsList.value = _value;
  void setError(String _value) => error.value = _value;

  AllJobViewModel() {
    now = DateTime.now();
    daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    day = DateTime(now.year, now.month, now.day);
  }

  void userListApi() {
    Map<String, dynamic> data = {
      'date': selectedDate.value != null
          ? DateFormat('yyyy-MM-dd').format(selectedDate.value!)
          : '',
    };

    _api.loadsApi(data).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    Map<String, dynamic> data = {
      'date': selectedDate.value != null
          ? DateFormat('yyyy-MM-dd').format(selectedDate.value!)
          : '',
    };

    _api.loadsApi(data).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void loadsApi() async {
    try {
      if (selectedDate.value != null) {
        Map<String, dynamic> data = {
          'date': DateFormat('yyyy-MM-dd').format(selectedDate.value!),
        };

        _api.loadsApi(data).then((value) {
          print('Date Uploaded');
        }).onError((error, stackTrace) {
          print("The error while sending data ${error.toString()}");
        });
      } else {
        print('No date selected.');
      }
    } catch (e) {
      print('Failed to Update, An error occurred while updating');
      return; // End the function
    }
  }

  void makeBidApi(String loadId) async {
    try {
      Map<String, dynamic> data = {
        'load_id': loadId,
        'message': messageController.value.text,
        'amount': bidController.value.text,
        'vehicle_info': vehicleTypeController.value.text,
      };

      Map<String, dynamic> response = await _api.makeBid(data);

      if (response != null && response['status_code'] == 200) {
        Utils.snackBar('Bid Uploaded', 'Successfully');
        updatePrice(bidController
            .value.text); // Assuming response contains the new price
      } else {
        Utils.snackBar(
            'Error', response['error'] ?? 'An error occurred while making bid');
      }
    } catch (e) {
      Utils.snackBar(
          'Failed to Bid', 'An unexpected error occurred while making bid');
      print("Unexpected error while making bid = ${e.toString()}");
    }
  }
}
