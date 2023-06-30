
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../driver_data_provider.dart';

class ViewRoute extends StatefulWidget {
  const ViewRoute({Key? key}) : super(key: key);

  @override
  State<ViewRoute> createState() => _ViewRouteState();
}

class _ViewRouteState extends State<ViewRoute> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.7726096, 39.2410419),
    zoom: 16.4746,
  );

  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    loadPickupPoints();
  }

  void loadPickupPoints() {
    final driverDataProvider = Provider.of<DriverData>(context, listen: false);
    List<GeoPoint> pickupPoints = driverDataProvider.pickupPoints;
    List<GeoPoint> emergencyPickupPoints =
        driverDataProvider.emergencyPickupPoints;

    setState(() {
      markers = [];
      markers.addAll(pickupPoints.map((point) {
        LatLng latLng = LatLng(point.latitude, point.longitude);
        return Marker(
          markerId: MarkerId(latLng.toString()),
          position: latLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: 'pickuppoint'),
        );
      }));

      markers.addAll(emergencyPickupPoints.map((point) {
        LatLng latLng = LatLng(point.latitude, point.longitude);
        return Marker(
          markerId: MarkerId(latLng.toString()),
          position: latLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: 'Emergency'),
        );
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers),
      ),
    );
  }
}



