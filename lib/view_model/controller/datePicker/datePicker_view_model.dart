import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DatePickerController extends GetxController {
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  void selectDate(DateTime date) {
    selectedDate.value = date;
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


}
