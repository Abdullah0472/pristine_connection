import 'dart:async';

import 'package:celient_project/data/response/status.dart';
import 'package:celient_project/model/loads/loads_model.dart';
import 'package:celient_project/repository/get_loads_repository/get_loads_repository.dart';
import 'package:celient_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllJobViewModel extends GetxController {
  final radiusController = TextEditingController().obs;
  final postalCodeController = TextEditingController().obs;
  final bidController = TextEditingController().obs;
  final messageController = TextEditingController().obs;
  final vehicleTypeController = TextEditingController().obs;

  RefreshController refreshController = RefreshController();

  RxString price = '0'.obs;

  //  updatePrice(String newPrice) {
  //   price.value = newPrice;
  // }

  String updatePrice(String newPrice) {
    price.value = newPrice;
    return price.value;
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
  int offset = 0;

  void selectDate(DateTime date) {
    if (selectedDate.value != date) {
      selectedDate.value = date;
      offset = 0; // Reset the offset to 0
      loadsList.value.data = []; // Clear the list of jobs
      loadsList
          .refresh(); // Notify listeners to rebuild the view and clear the previous data
      setRxRequestStatus(Status.LOADING); // Set the loading status
      Future.delayed(Duration(milliseconds: 100), () {
        userListApi();
        update(); // Make a network call when a date is selected
      });
    }
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

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setLoadsList(LoadsModel _value) => loadsList.value = _value;
  void setError(String _value) => error.value = _value;
  AllJobViewModel() {
    now = DateTime.now();
    daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    day = DateTime(now.year, now.month, now.day);
  }
  ScrollController scrollController = ScrollController();
  RxBool isLoadingNextOffset = false.obs; // add this variable
  void addScrollListener() {
    scrollController.addListener(() {
      // Load more when scrolled to the bottom
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMoreData.value) {
        offset += 1;
        userListApi();
      }
      // Load previous when scrolled to the top
      else if (scrollController.position.pixels ==
              scrollController.position.minScrollExtent &&
          offset > 0) {
        offset -= 1;
        userListApi();
      }
    });
  }

  RxBool hasMoreData = true.obs;

  void userListApi() {
    if (selectedDate.value != null) {
      Map<String, dynamic> data = {
        'date': DateFormat('yyyy-MM-dd').format(selectedDate.value!),
        'offset': offset.toString(),
      };
      isLoadingNextOffset.value = true;
      _api.loadsApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        if (value.data != null) {
          hasMoreData.value = value.data!.length >= 10;
        } else {
          hasMoreData.value = false;
        }
        appendLoadsList(value); // call appendLoadsList instead of setLoadsList
        isLoadingNextOffset.value = false;
      }).onError((error, stackTrace) {
        isLoadingNextOffset.value = false;
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
      });
    } else {
      print('No date selected.');
    }
  }

   refreshApi() {
    setRxRequestStatus(Status.LOADING);
    Map<String, dynamic> data = {
      'date': selectedDate.value != null
          ? DateFormat('yyyy-MM-dd').format(selectedDate.value!)
          : '',
      'offset': offset.toString(),
    };
    isLoadingNextOffset.value = true;
    _api.loadsApi(data).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      if (value.data != null) {
        hasMoreData.value = value.data!.length >= 10;
      } else {
        hasMoreData.value = false;
      }
      appendLoadsList(value); // call appendLoadsList instead of setLoadsList
      isLoadingNextOffset.value = false;
    }).onError((error, stackTrace) {
      isLoadingNextOffset.value = false;
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void appendLoadsList(LoadsModel value) {
    if (loadsList.value.data == null) {
      loadsList.value.data = value.data ?? [];
    } else {
      loadsList.value.data?.addAll(value.data ?? []);
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
        String updatedPrice = updatePrice(bidController.value.text);
        print("The Bid Amount is $updatedPrice");

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
