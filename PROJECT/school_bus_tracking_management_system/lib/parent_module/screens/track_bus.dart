
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;


import '../providers/parent_data_provider.dart';

class TrackBus extends StatefulWidget {
  const TrackBus({Key? key}) : super(key: key);

  @override
  State<TrackBus> createState() => _TrackBusState();
}

class _TrackBusState extends State<TrackBus> {
  GoogleMapController? _mapController;
  DatabaseReference? locationRef;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    // Fetch bus location
    locationRef = FirebaseDatabase.instance
        .ref()
        .child('bus/UMGDchJFToQ8qwJd2hFRnzYegzG3/bus 2/location');

    // Listen to bus location changes
    locationRef!.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final locationData = event.snapshot.value as Map<dynamic, dynamic>;

        if (locationData['latitude'] != null &&
            locationData['longitude'] != null) {
          final latitude = double.tryParse(locationData['latitude'].toString());
          final longitude =
              double.tryParse(locationData['longitude'].toString());

          if (latitude != null && longitude != null) {
            setState(() {
              markers.removeWhere((marker) => marker.markerId.value == 'bus');
              markers.add(
                Marker(
                  markerId: MarkerId('bus'),
                  position: LatLng(latitude, longitude),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen,
                  ),
                ),
              );
            });
          }
        }
      }
    });
  }

  Stream<Set<Marker>> getPickupPointsStream() {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('userRecords')
        .where('role', isEqualTo: 'parent')
        .where('busAssigned', isEqualTo: 'bus 2')
         .where('email', isEqualTo:user!.email)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs
          .map((doc) => doc['pickuppoint'] as GeoPoint?)
          .where((geoPoint) => geoPoint != null)
          .map((geoPoint) => Marker(
                markerId: MarkerId(geoPoint.toString()),
                position: LatLng(geoPoint!.latitude, geoPoint.longitude),
                icon: BitmapDescriptor.defaultMarker,
              ))
          .toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Set<Marker>>(
        stream: getPickupPointsStream(),
        builder: (BuildContext context, AsyncSnapshot<Set<Marker>> snapshot) {
          if (snapshot.hasData) {
            final pickupPoints = snapshot.data!;
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(-6.7725830, 39.2408590),
                zoom: 18,
              ),
              markers: pickupPoints.union(markers),
              onMapCreated: (controller) {
                _mapController = controller;
              },
            );
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void dispose() {
    locationRef?.onValue.drain();
    super.dispose();
  }
}

