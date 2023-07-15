import 'package:celient_project/model/current_trip/current_trip_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadStatusPrefernce {

  // Future<bool> saveLoadStatus(CurrentTripModel responseModel) async {
  //   print('Saving load Status...');
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   sp.setString('load_status', responseModel.data![0].loadStatus ?? '');
  //   print('Load Status saved.');
  //   return true;
  // }

  Future<bool> saveLoadStatus(String loadStatus) async {
    print('Saving load Status...');
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('load_status', loadStatus);
    print('Load Status saved.');
    return true;
  }



  // Future<CurrentTripModel> getLoadStatus() async {
  //   print('Getting load Status...');
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   String? loadStatus = sp.getString('load_status');
  //   print('Load Status got.');
  //
  //   return CurrentTripModel(
  //     data: [Data(loadStatus: loadStatus)], // assign the data object to a List<Data>
  //   );
  // }

  Future<String?> getLoadStatus() async {
    print('Getting load Status...');
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? loadStatus = sp.getString('load_status');
    print('Load Status got.');
    return loadStatus;
  }


  Future<bool> removeLoadStatus() async {
    print('Removing laod Status...');
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    print('load Status removed.');
    return true;
  }
}
