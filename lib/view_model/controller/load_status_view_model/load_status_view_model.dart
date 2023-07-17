import 'dart:async';

import 'package:celient_project/model/current_trip/current_trip_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoadStatusPreference {
  final _loadStatusStreamController = StreamController<String>.broadcast();

  // Initialize load status from shared preferences
  LoadStatusPreference() {
    getLoadStatus().then((loadStatus) {
      _loadStatusStreamController.add(loadStatus);
    });
  }

  // Stream<String> get loadStatusStream => _loadStatusStreamController.stream;
  //
  // Future<bool> saveLoadStatus(String loadStatus) async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   sp.setString('load_status', loadStatus);
  //   _loadStatusStreamController.add(loadStatus);
  //   return true;
  // }
  //
  // Future<String> getLoadStatus() async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   String loadStatus = sp.getString('load_status') ?? 'default';
  //   return loadStatus;
  // }

 // final _loadStatusStreamController = StreamController<String>.broadcast();
  Stream<String> get loadStatusStream => _loadStatusStreamController.stream;

  Future<void> saveLoadStatus(String loadStatus) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('load_status', loadStatus);
    _loadStatusStreamController.add(loadStatus);
  }

  Future<String> getLoadStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String loadStatus = sp.getString('load_status') ?? 'default';
    return loadStatus;
  }

  Future<bool> removeLoadStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('load_status');
    _loadStatusStreamController.add('default');
    return true;
  }

  // Don't forget to close your stream
  void dispose() {
    _loadStatusStreamController.close();
  }
}
