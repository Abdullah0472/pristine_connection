
import 'package:celient_project/model/login/login_model.dart';
import 'package:celient_project/res/app_url/app_url.dart';
import 'package:celient_project/view_model/controller/user_preference/user_prefrence_view_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class UpdateLocationServices extends GetxController {
  Timer? timer;
  UserPreference userPreference = UserPreference();
  String? getUniqueId;


  // @override
  // void onInit() async {
  //   super.onInit();
  //   // Initialize getUniqueId in the onInit method
  //   LoginModel userModel = await userPreference.getUser();
  //   getUniqueId = userModel.data?.uniqueId;
  //
  //   print("The Unique Id is = $getUniqueId");
  //   requestLocationPermission().then((isGranted) {
  //     if (isGranted) {
  //       startLocationUpdates();
  //     } else {
  //       print("Location permission not granted.");
  //
  //     }
  //   });
  // }

  @override
  void onInit() async {
    super.onInit();
    // Initialize getUniqueId in the onInit method
    LoginModel userModel = await userPreference.getUser();
    print('The Unique Id is ${userModel.data?.uniqueId }');
    if (userModel.data != null) {
      getUniqueId = userModel.data!.uniqueId;
    } else {
      print('Error obtaining UniqueId: userModel.data is null');
      return; // Abort further execution if userModel.data is null
    }

    requestLocationPermission().then((isGranted) {
      if (isGranted) {
        startLocationUpdates();
      } else {
        print("Location permission not granted.");
      }
    });
  }




  void startLocationUpdates() {
    timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      if (await requestLocationPermission()) {
        try {
          Position? position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
          if (position != null) {
            updateLocation(position, getUniqueId!);
          } else {
            print('Error obtaining location: position is null');
          }
        } catch (e) {
          print('Error obtaining location: $e');
        }
      } else {
        print('Location permission not granted.');
      }
    });
  }



  Future<void> updateLocation(Position locationData, String id) async {
    try {
      Uri uri = Uri.http(AppUrl.serverUrl, '/', {
        'id': id,
        'timestamp': locationData.timestamp!.millisecondsSinceEpoch.toString(),
        'lat': locationData.latitude.toString(),
        'lon': locationData.longitude.toString(),
        'speed': locationData.speed.toString(),
        'bearing': locationData.heading.toString(),
        'altitude': locationData.altitude.toString(),
        'accuracy': locationData.accuracy.toString(),
        'batt': '100'
      });

      final response = await http.get(uri);
      print('HTTP Status Code: ${response.statusCode}');
    } catch (e) {
      // Handle error when the HTTP request fails
      print('Error sending location update: $e');
    }
  }


  Future<bool> requestLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        // Handle the case when the user has permanently denied location permission
        print('Location permission denied forever.');
        return false;
      }

      return permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } catch (e) {
      // Handle error when requesting location permission fails
      print('Error requesting location permission: $e');
      return false;
    }
  }


}
