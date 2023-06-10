// ignore_for_file: prefer_const_constructors, unused_field

//import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/parent_data_provider.dart';

class TrackBus extends StatefulWidget {
  const TrackBus({super.key});

  @override
  State<TrackBus> createState() => _TrackBusState();
}

class _TrackBusState extends State<TrackBus> {
GoogleMapController? _mapController;
//Set<Marker> _markers = {};
   //final Completer<GoogleMapController> _controller =
     // Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.7726096, 39.2410419),
    zoom: 16.4746,
  );
  @override
  Widget build(BuildContext context) {
    UserData userdataprovider = Provider.of<UserData>(context, listen: false);
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('bus')
            .doc(userdataprovider.busNo) // Assuming busId is stored in the UserData provider
            .snapshots(),
        builder: (context, snapshot) {
         LatLng initialPosition = LatLng(-6.7726096, 39.2410419);
          Set<Marker> markers = {};

          if (snapshot.hasData) {
            final busData = snapshot.data!.data();

            if (busData != null && busData.containsKey('location')) {
              final geoPoint = busData['location'] as GeoPoint;
              final latLng = LatLng(geoPoint.latitude, geoPoint.longitude);

              markers = {
                Marker(
                  markerId: MarkerId('bus'),
                  position: latLng,
                  icon: BitmapDescriptor.defaultMarker,
                  
                ),
              };

              initialPosition = latLng;
            }
          }
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialPosition,
              zoom: 12,
            ),
            markers: markers,
          );
          },
      ),
    

      // GoogleMap(
      //   mapType: MapType.normal,
      //   initialCameraPosition: _kGooglePlex,
      //   onMapCreated: (GoogleMapController controller) {
      //     _controller.complete(controller);
      //   },
      // ),
    );
  }
}
