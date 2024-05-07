
import 'dart:async';
import 'package:cooler_mdlz/common/common.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../app/utlis/utils.dart';
import '../model/entities.dart';

class GoogleMapPage extends StatefulWidget {
  static const route = '/google_map_screen';

  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late OwnThemeFields themeOwn;
  final Completer<GoogleMapController> _controllerGoogleMap  = Completer();
  late OutletModel outletModel;
  late LatLng outletLocation;
  late LatLng currentLocation;
  late CameraPosition _cameraPosition;
  late Marker outletMarker;

  @override
  void initState() {
    super.initState();
    outletModel = Get.arguments;
    outletLocation = LatLng(outletModel.lat!, outletModel.long!);
    _cameraPosition = CameraPosition(
      target: outletLocation,
      zoom: 20,
    );
    outletMarker = Marker(
      markerId: MarkerId(outletModel.id.toString()),
      position: outletLocation,
      infoWindow: InfoWindow(
        title: outletModel.name,
        snippet: outletModel.address,
      ),
    );
    _markers.add(outletMarker);
    getCurrentLocation().then((value) async {
      currentLocation = LatLng(value.latitude, value.longitude);
      final GoogleMapController controller = await _controllerGoogleMap.future;
      LatLngBounds bound = boundsFromLatLngList([currentLocation, outletLocation]);
      CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bound, 50);
      controller.animateCamera(cameraUpdate);
    });
  }

  _onMapCreated(GoogleMapController controller) {
    controller.showMarkerInfoWindow(outletMarker.markerId);
    _controllerGoogleMap.complete(controller);
  }

  final List<Marker> _markers = <Marker>[];

  Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    themeOwn = Theme.of(context).own();
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        titleSpacing: 0,
        backgroundColor: themeOwn.mainColor,
        elevation: 0.0,
      ),
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        markers: Set<Marker>.of(_markers),
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        mapToolbarEnabled: false,
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
        myLocationEnabled: true,
        mapType: MapType.normal,
        compassEnabled: false,
        onMapCreated: _onMapCreated,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getCurrentLocation().then((value) async {
            currentLocation = LatLng(value.latitude, value.longitude);
            final GoogleMapController controller = await _controllerGoogleMap.future;
            LatLngBounds bound = boundsFromLatLngList([currentLocation, outletLocation]);
            CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bound, 50);
            controller.animateCamera(cameraUpdate);
          });
        },
        backgroundColor: themeOwn.mainColor,
        child: const Icon(Icons.send),
      ),
    );
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }

}
