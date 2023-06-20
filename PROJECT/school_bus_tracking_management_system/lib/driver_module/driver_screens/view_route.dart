// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, dead_code, prefer_collection_literals

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

  @override
  Widget build(BuildContext context) {
    final driverdataProvider = Provider.of<DriverData>(context);
    List<GeoPoint> pickupPoints = driverdataProvider.pickupPoints;
    List<GeoPoint> emergencyPickupPoints =
        driverdataProvider.emergencyPickupPoints;

    List<Marker> markers = pickupPoints.map((point) {
      LatLng latLng = LatLng(point.latitude, point.longitude);
      return Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(title: 'pickuppoint'),
      );
    }).toList();

    List<Marker> emergencyMarkers = emergencyPickupPoints.map((point) {
      LatLng latLng = LatLng(point.latitude, point.longitude);
      return Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: 'Emergency'),
      );
    }).toList();

    // List<Marker> allMarkers = [];
    // setState(() {
    //   allMarkers.addAll(markers);
    //   allMarkers.addAll(emergencyMarkers);
    
    // });
    
    List<LatLng> polylinePoints = pickupPoints .map((point) {
      return LatLng(point.latitude, point.longitude);
    }).toList();

    Polyline polyline = Polyline(
      polylineId: PolylineId('pickup_route'),
      color: Colors.blue,
      points: polylinePoints,
      width: 5,
    );

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(emergencyMarkers+markers),
        polylines: Set<Polyline>.of([polyline]),
      ),
    );
  }
}
