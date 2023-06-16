// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'package:celient_project/view_model/controller/loadDetail/loadDetail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class GoogleMapTabBarVIew extends StatefulWidget {
  const GoogleMapTabBarVIew({
    Key? key,
  }) : super(key: key);

  @override
  _GoogleMapTabBarVIewState createState() => _GoogleMapTabBarVIewState();
}

class _GoogleMapTabBarVIewState extends State<GoogleMapTabBarVIew> {
  // final Completer<GoogleMapController> _controller = Completer();
  final loadDetailVM = Get.put(loadDetailViewModel());
  String mapTheme = '';
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(24.88453, 67.07886),
    zoom: 15,
  );
  final List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/retro_theme.json')
        .then((value) {
      mapTheme = value;
    });
    loadData();
  }

  loadData() {
    getUserCurrentLocation().then((value) async {

      CameraPosition cameraPosition = CameraPosition(
        zoom: 18,
        target: LatLng(
          value.latitude,
          value.longitude,
        ),
      );

      final GoogleMapController controller = await loadDetailVM.controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {});
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
    });
    return await Geolocator.getCurrentPosition();
  }

  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationEnabled: true,
      initialCameraPosition: _kGooglePlex,
      markers: Set<Marker>.of(_markers),
      onMapCreated: (GoogleMapController controller) {
        loadDetailVM.controller.complete(controller);
      },
    );

  }
}
