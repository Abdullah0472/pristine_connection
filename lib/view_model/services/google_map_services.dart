

import 'dart:math';
import 'package:celient_project/view_model/controller/current_trip/current_trip_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapServices extends GetxController {

  final currentTripVM = Get.put(CurrentTripController());
  CameraPosition initialLocation = const CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;

  var currentPosition = Rx<Position?>(null);
  var currentAddress = ''.obs;
  var startAddress = ''.obs;
  var destinationAddress = ''.obs;
  var placeDistance = Rx<String?>("0");

  Set<Marker> markers = {};

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];


  getCurrentLocation() async {
    print('Getting current location...'); // Add this line
      await Geolocator.requestPermission()
          .then((value) {})
          .onError((error, stackTrace) {
        print('error$error');
      });
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentPosition.value = position;
      print('CURRENT POS: ${currentPosition.value}');
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0,
          ),
        ),
      );
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }




  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          currentPosition.value!.latitude, currentPosition.value!.longitude);

      Placemark place = p[0];

      currentAddress.value = "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
      startAddress.value = currentAddress.value;
      print("The Current Address ${currentAddress.value}");
      print("The Start Address  ${startAddress.value}");
    } catch (e) {
      print(e);
    }
  }

  Future<bool> calculateDistance(int index) async {
    try {
      print('Calculating distance...'); // Add this line
      // Retrieving placemarks from addresses
      List<Location> startPlacemark = await locationFromAddress(startAddress.value);
      // List<Location> destinationPlacemark = await locationFromAddress(currentTripVM.currentTripList.value.data![index].pickupLocation);

      String? destinationAddress = currentTripVM.currentTripList.value.data![index].loadStatus == "started"
          ? currentTripVM.currentTripList.value.data![index].pickupLocation
          : currentTripVM.currentTripList.value.data![index].deliveryLocation;

// Here we use the null-coalescing operator (??) to handle the case where destinationAddress might be null.
      List<Location> destinationPlacemark = await locationFromAddress(destinationAddress ?? "Default Address");

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = startAddress.value == currentAddress.value
          ? currentPosition.value!.latitude
          : startPlacemark[0].latitude;

      double startLongitude = startAddress.value == currentAddress.value
          ? currentPosition.value!.longitude
          : startPlacemark[0].longitude;

      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString = '($destinationLatitude, $destinationLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: startAddress.value,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: currentTripVM.currentTripList.value.data![index].pickupLocation,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      print(
        'START COORDINATES: ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
      );

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      // Accommodate the two locations within the
      // camera view of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );
      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);

      double totalDistance = 0.0;

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {

        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }
      print('Polyline coordinates: $polylineCoordinates');

      placeDistance.value = totalDistance.toStringAsFixed(2);
      print('DISTANCE: ${placeDistance.value} km');

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }


  // Formula for calculating distance between two coordinates
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // Create the polylines for showing the route between two places
  _createPolylines(
      double startLatitude,
      double startLongitude,
      double destinationLatitude,
      double destinationLongitude,
      ) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBCgMkgjHVW3WL4GD4M6FdLar-tjlIT8aU', // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print('Error fetching polyline: ${result.status}');
      return false;
    }

    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }

}
