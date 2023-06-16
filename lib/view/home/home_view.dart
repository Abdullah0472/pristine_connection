// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:celient_project/res/components/widgets/cards/load_cards.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Completer<GoogleMapController> _controller = Completer();
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
      // _markers.add(
      //   Marker(
      //     markerId: const MarkerId('2'),
      //     position: LatLng(
      //       value.latitude,
      //       value.longitude,
      //     ),
      //     infoWindow: const InfoWindow(
      //       title: "Your Current Location",
      //     ),
      //   ),
      // );
      CameraPosition cameraPosition = CameraPosition(
        zoom: 18,
        target: LatLng(
          value.latitude,
          value.longitude,
        ),
      );

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {});
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('error$error');
    });
    return await Geolocator.getCurrentPosition();
  }

  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        icon: true,
        actionIcon: true,
        action: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () {
                _controller.future.then(
                  (value) {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/maptheme/silver_theme.json')
                        .then(
                      (string) {
                        value.setMapStyle(string);
                      },
                    );
                  },
                );
              },
              child: const Text('Silver'),
            ),
            PopupMenuItem(
              onTap: () {
                _controller.future.then(
                  (value) {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/maptheme/retro_theme.json')
                        .then(
                      (string) {
                        value.setMapStyle(string);
                      },
                    );
                  },
                );
              },
              child: const Text('Retro'),
            ),
            PopupMenuItem(
              onTap: () {
                _controller.future.then(
                  (value) {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/maptheme/night_theme.json')
                        .then(
                      (string) {
                        value.setMapStyle(string);
                      },
                    );
                  },
                );
              },
              child: const Text('Night'),
            ),
          ],
        ),
        title: 'Trips on Going',
      ),
      body: SafeArea(
        child: Stack(alignment: AlignmentDirectional.center, children: [
          GoogleMap(
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          const Positioned(
              top: 60,
              child: LoadCards(
                refNumber: '458',
                currentAddress:
                    '40 Business Man Colony Rahim Yar Khan Punjab Pakistan ',
                dateTime: 'Tue 06 2021 14:30',
                piece: '3',
                dims: '3-5-8',
                weight: '487',
                miles: '1258',
                pickupName: 'Amjad',
                pickupAddress: 'Thokar Niaz Baig, Lahore',
                pickupDateTime: 'Wed 08 2021 14:45',
                deliveryName: 'Faisal',
                deliveryAddress: '40 Business Man Colony Rahim Yar Khan Punjab Pakistan',
                deliveryDateTime: 'Wed 08 2021 14:45',
              ))
        ]),
      ),
    );
  }
}
