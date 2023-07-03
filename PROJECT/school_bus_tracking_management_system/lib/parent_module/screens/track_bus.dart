// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_database/firebase_database.dart';
// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:provider/provider.dart';
// // import 'package:firebase_auth/firebase_auth.dart' as auth;

// // import '../providers/parent_data_provider.dart';

// // class TrackBus extends StatefulWidget {
// //   const TrackBus({Key? key}) : super(key: key);

// //   @override
// //   State<TrackBus> createState() => _TrackBusState();
// // }

// // class _TrackBusState extends State<TrackBus> {
// //   GoogleMapController? _mapController;
// //   DatabaseReference? locationRef;
// //   Set<Marker> markers = {};

// //   @override
// //   void initState() {
// //     super.initState();

// //     // Fetch bus location
// //     locationRef = FirebaseDatabase.instance
// //         .ref()
// //         .child('bus/UMGDchJFToQ8qwJd2hFRnzYegzG3/bus 2/location');

// //     // Listen to bus location changes
// //     locationRef!.onValue.listen((event) {
// //       if (event.snapshot.value != null) {
// //         final locationData = event.snapshot.value as Map<dynamic, dynamic>;

// //         if (locationData['latitude'] != null &&
// //             locationData['longitude'] != null) {
// //           final latitude = double.tryParse(locationData['latitude'].toString());
// //           final longitude =
// //               double.tryParse(locationData['longitude'].toString());

// //           if (latitude != null && longitude != null) {
// //             setState(() {
// //               markers.removeWhere((marker) => marker.markerId.value == 'bus');
// //               markers.add(
// //                 Marker(
// //                   markerId: MarkerId('bus'),
// //                   position: LatLng(latitude, longitude),
// //                   icon: BitmapDescriptor.defaultMarkerWithHue(
// //                     BitmapDescriptor.hueGreen,
// //                   ),
// //                 ),
// //               );
// //             });
// //           }
// //         }
// //       }
// //     });
// //   }

// //   Stream<Set<Marker>> getPickupPointsStream() {
// //     auth.User? user = auth.FirebaseAuth.instance.currentUser;
// //     return FirebaseFirestore.instance
// //         .collection('userRecords')
// //         .where('role', isEqualTo: 'parent')
// //         .where('busAssigned', isEqualTo: 'bus 2')
// //          .where('email', isEqualTo:user!.email)
// //         .snapshots()
// //         .map((QuerySnapshot snapshot) {
// //       return snapshot.docs
// //           .map((doc) => doc['pickuppoint'] as GeoPoint?)
// //           .where((geoPoint) => geoPoint != null)
// //           .map((geoPoint) => Marker(
// //                 markerId: MarkerId(geoPoint.toString()),
// //                 position: LatLng(geoPoint!.latitude, geoPoint.longitude),
// //                 icon: BitmapDescriptor.defaultMarker,
// //               ))
// //           .toSet();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: StreamBuilder<Set<Marker>>(
// //         stream: getPickupPointsStream(),
// //         builder: (BuildContext context, AsyncSnapshot<Set<Marker>> snapshot) {
// //           if (snapshot.hasData) {
// //             final pickupPoints = snapshot.data!;
// //             return GoogleMap(
// //               initialCameraPosition: CameraPosition(
// //                 target: LatLng(-6.7725830, 39.2408590),
// //                 zoom: 18,
// //               ),
// //               markers: pickupPoints.union(markers),
// //               onMapCreated: (controller) {
// //                 _mapController = controller;
// //               },
// //             );
// //           }
// //           if (snapshot.hasError) {
// //             return Text('Error: ${snapshot.error}');
// //           }
// //           return Center(child: CircularProgressIndicator());
// //         },
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     locationRef?.onValue.drain();
// //     super.dispose();
// //   }
// // }

// // draws a polyline btn specified points

// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// // class TrackBus extends StatefulWidget {
// //   @override
// //   _TrackBusState createState() => _TrackBusState();
// // }

// // class _TrackBusState extends State<TrackBus> {
// //   late GoogleMapController mapController;
// //   double _originLatitude = -6.775709, _originLongitude = 39.244236;
// //   double _destLatitude = -6.775336, _destLongitude = 39.241775;
// //   Map<MarkerId, Marker> markers = {};
// //   Map<PolylineId, Polyline> polylines = {};
// //   List<LatLng> polylineCoordinates = [];
// //   PolylinePoints polylinePoints = PolylinePoints();
// //   String googleAPiKey = "AIzaSyC7Of1-Po6ADavFd6jgz8VvxEB5mUXvDGo";

// //   @override
// //   void initState() {
// //     super.initState();
// //     _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
// //         BitmapDescriptor.defaultMarker);
// //     _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
// //         BitmapDescriptor.defaultMarkerWithHue(90));
// //     _getPolyline();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         body: GoogleMap(
// //           initialCameraPosition: CameraPosition(
// //               target: LatLng(_originLatitude, _originLongitude), zoom: 15),
// //           myLocationEnabled: true,
// //           tiltGesturesEnabled: true,
// //           compassEnabled: true,
// //           scrollGesturesEnabled: true,
// //           zoomGesturesEnabled: true,
// //           onMapCreated: _onMapCreated,
// //           markers: Set<Marker>.of(markers.values),
// //           polylines: Set<Polyline>.of(polylines.values),
// //         ),
// //       ),
// //     );
// //   }

// //   void _onMapCreated(GoogleMapController controller) async {
// //     mapController = controller;
// //   }

// //   _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
// //     MarkerId markerId = MarkerId(id);
// //     Marker marker =
// //         Marker(markerId: markerId, icon: descriptor, position: position);
// //     markers[markerId] = marker;
// //   }

// //   _addPolyLine() {
// //     PolylineId id = PolylineId("poly");
// //     Polyline polyline = Polyline(
// //         polylineId: id, color: Colors.red, points: polylineCoordinates);
// //     polylines[id] = polyline;
// //     setState(() {});
// //   }

// //   _getPolyline() async {
// //     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
// //       googleAPiKey,
// //       PointLatLng(_originLatitude, _originLongitude),
// //       PointLatLng(_destLatitude, _destLongitude),
// //       travelMode: TravelMode.driving,
// //     );

// //     if (result.status == "OK") {
// //       result.points.forEach((PointLatLng point) {
// //         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
// //       });
// //     }

// //     _addPolyLine();
// //   }
// // }

// // ignore_for_file: dead_code

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_database/firebase_database.dart';
// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:provider/provider.dart';
// // import 'package:firebase_auth/firebase_auth.dart' as auth;
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// // class TrackBus extends StatefulWidget {
// //   const TrackBus({Key? key}) : super(key: key);

// //   @override
// //   State<TrackBus> createState() => _TrackBusState();
// // }

// // class _TrackBusState extends State<TrackBus> {
// //   GoogleMapController? _mapController;
// //   DatabaseReference? locationRef;
// //   Set<Marker> markers = {};
// //   Map<PolylineId, Polyline> polylines = {};
// //   List<LatLng> polylineCoordinates = [];
// //   PolylinePoints polylinePoints = PolylinePoints();
// //   //LatLng buspoints = LatLng();

// //   @override
// //   void initState() {
// //     super.initState();

// //     // Fetch bus location
// //     locationRef = FirebaseDatabase.instance
// //         .ref()
// //         .child('bus/UMGDchJFToQ8qwJd2hFRnzYegzG3/bus 2/location');

// //     // Listen to bus location changes
// //     locationRef!.onValue.listen((event) {
// //       if (event.snapshot.value != null) {
// //         final locationData = event.snapshot.value as Map<dynamic, dynamic>;

// //         if (locationData['latitude'] != null &&
// //             locationData['longitude'] != null) {
// //           final latitude = double.tryParse(locationData['latitude'].toString());
// //           final longitude =
// //               double.tryParse(locationData['longitude'].toString());

// //           if (latitude != null && longitude != null) {
// //             setState(() {
// //               markers.removeWhere((marker) => marker.markerId.value == 'bus');
// //               markers.add(
// //                 Marker(
// //                   markerId: MarkerId('bus'),
// //                   position: LatLng(latitude, longitude),
// //                   icon: BitmapDescriptor.defaultMarkerWithHue(
// //                     BitmapDescriptor.hueGreen,
// //                   ),
// //                 ),
// //               );
// //               _getPolyline(
// //                 origin: LatLng(latitude, longitude),
// //               );
// //             });
// //           }
// //         }
// //       }
// //     });
// //   }

// //   Stream<Set<Marker>> getPickupPointsStream() {
// //     auth.User? user = auth.FirebaseAuth.instance.currentUser;
// //     return FirebaseFirestore.instance
// //         .collection('userRecords')
// //         .where('role', isEqualTo: 'parent')
// //         .where('busAssigned', isEqualTo: 'bus 2')
// //         .where('email', isEqualTo: user!.email)
// //         .limit(1)
// //         .snapshots()
// //         .map(
// //       (QuerySnapshot snapshot) {
// //         return snapshot.docs
// //             .map((doc) => doc['pickuppoint'] as GeoPoint?)
// //             .where((geoPoint) => geoPoint != null)
// //             .map((geoPoint) => Marker(
// //                   markerId: MarkerId(geoPoint.toString()),
// //                   position: LatLng(geoPoint!.latitude, geoPoint.longitude),
// //                   icon: BitmapDescriptor.defaultMarker,
// //                 ))
// //             .toSet();
// //       },
// //     );
// //   }

// //   // _getPolyline(destination:LatLng(latitude, longitude));

// // Future<void> _getPolyline({LatLng? destination, LatLng? origin}) async {
// //   try {
// //     auth.User? user = auth.FirebaseAuth.instance.currentUser;
// //     final snapshot = await FirebaseFirestore.instance
// //         .collection('userRecords')
// //         .where('role', isEqualTo: 'parent')
// //         .where('busAssigned', isEqualTo: 'bus 2')
// //         .where('email', isEqualTo: user!.email)
// //         .limit(1)
// //         .get();

// //     if (snapshot.docs.isNotEmpty) {
// //       final doc = snapshot.docs.first;
// //       final pickupPoint = doc['pickuppoint'] as GeoPoint;
// //       final latitude = pickupPoint.latitude;
// //       final longitude = pickupPoint.longitude;

// //       PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
// //         "AIzaSyC7Of1-Po6ADavFd6jgz8VvxEB5mUXvDGo",
// //         PointLatLng(destination!.latitude, destination.longitude),
// //         PointLatLng(latitude,longitude ), // Use the fetched pickup point
// //         travelMode: TravelMode.driving,
// //       );

// //       if (result.status == "OK") {
// //         setState(() {
// //           polylineCoordinates.clear();
// //           result.points.forEach((PointLatLng point) {
// //             polylineCoordinates.add(LatLng(point.latitude, point.longitude));
// //           });

// //           PolylineId id = PolylineId("poly");
// //           Polyline polyline = Polyline(
// //             polylineId: id,
// //             color: Colors.red,
// //             points: polylineCoordinates,
// //           );
// //           polylines.clear();
// //           polylines[id] = polyline;
// //         });
// //       }
// //     } else {
// //       // No matching document found
// //       print('No matching document found');
// //     }
// //   } catch (e) {
// //     // Error occurred while fetching data
// //     print('Error fetching pickup point: $e');
// //   }
// // }

// //   // Future<void> _getPolyline({LatLng? destination, LatLng? origin}) async {
// //   //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
// //   //     "AIzaSyC7Of1-Po6ADavFd6jgz8VvxEB5mUXvDGo",
// //   //     PointLatLng(destination!.latitude, destination.longitude),
// //   //     PointLatLng(-6.7725830, 39.2408590),       // Replace with the bus location
// //   //     travelMode: TravelMode.driving,
// //   //   );

// //   //   if (result.status == "OK") {
// //   //     setState(() {
// //   //       polylineCoordinates.clear();
// //   //       result.points.forEach((PointLatLng point) {
// //   //         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
// //   //       });

// //   //       PolylineId id = PolylineId("poly");
// //   //       Polyline polyline = Polyline(
// //   //         polylineId: id,
// //   //         color: Colors.red,
// //   //         points: polylineCoordinates,
// //   //       );
// //   //       polylines.clear();
// //   //       polylines[id] = polyline;
// //   //     });
// //   //   }
// //   // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: StreamBuilder<Set<Marker>>(
// //         stream: getPickupPointsStream(),
// //         builder: (BuildContext context, AsyncSnapshot<Set<Marker>> snapshot) {
// //           if (snapshot.hasData) {
// //             final pickupPoints = snapshot.data!;
// //             return GoogleMap(
// //               initialCameraPosition: CameraPosition(
// //                 target: LatLng(-6.7725830, 39.2408590),
// //                 zoom: 18,
// //               ),
// //               markers: pickupPoints.union(markers),
// //               polylines: Set<Polyline>.of(polylines.values),
// //               onMapCreated: (controller) {
// //                 _mapController = controller;
// //               },
// //             );
// //           }
// //           if (snapshot.hasError) {
// //             return Text('Error: ${snapshot.error}');
// //           }
// //           return Center(child: CircularProgressIndicator());
// //         },
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     locationRef?.onValue.drain();
// //     super.dispose();
// //   }
// // }

// //fetch point
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart' as auth;
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// class TrackBus extends StatefulWidget {
//   const TrackBus({Key? key}) : super(key: key);

//   @override
//   State<TrackBus> createState() => _TrackBusState();
// }

// class _TrackBusState extends State<TrackBus> {
//   GoogleMapController? _mapController;
//   DatabaseReference? locationRef;
//   Set<Marker> markers = {};
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();

//   @override
//   void initState() {
//     super.initState();

//     // Fetch bus location
//     locationRef = FirebaseDatabase.instance
//         .ref()
//         .child('bus/UMGDchJFToQ8qwJd2hFRnzYegzG3/bus 2/location');

//     // Listen to bus location changes
//     locationRef!.onValue.listen((event) {
//       if (event.snapshot.value != null) {
//         final locationData = event.snapshot.value as Map<dynamic, dynamic>;

//         if (locationData['latitude'] != null &&
//             locationData['longitude'] != null) {
//           final latitude = double.tryParse(locationData['latitude'].toString());
//           final longitude =
//               double.tryParse(locationData['longitude'].toString());

//           if (latitude != null && longitude != null) {
//             setState(() {
//               markers.removeWhere((marker) => marker.markerId.value == 'bus');
//               markers.add(
//                 Marker(
//                   markerId: MarkerId('bus'),
//                   position: LatLng(latitude, longitude),
//                   icon: BitmapDescriptor.defaultMarkerWithHue(
//                     BitmapDescriptor.hueGreen,
//                   ),
//                 ),
//               );
//               _getPolyline(destination:LatLng(latitude, longitude));
//             });
//           }
//         }
//       }
//     });
//   }

//   Stream<Set<Marker>> getPickupPointsStream() {
//     auth.User? user = auth.FirebaseAuth.instance.currentUser;
//     return FirebaseFirestore.instance
//         .collection('userRecords')
//         .where('role', isEqualTo: 'parent')
//         .where('busAssigned', isEqualTo: 'bus 2')
//         .where('email', isEqualTo: user!.email)
//         .snapshots()
//         .map((QuerySnapshot snapshot) {
//       return snapshot.docs
//           .map((doc) => doc['pickuppoint'] as GeoPoint?)
//           .where((geoPoint) => geoPoint != null)
//           .map((geoPoint) => Marker(
//                 markerId: MarkerId(geoPoint.toString()),
//                 position: LatLng(geoPoint!.latitude, geoPoint.longitude),
//                 icon: BitmapDescriptor.defaultMarker,
//               ))
//           .toSet();
//     });
//   }

//   //
//   Future<void> _getPolyline({LatLng? destination, LatLng? origin}) async {
//   try {
//     auth.User? user = auth.FirebaseAuth.instance.currentUser;
//     final snapshot = await FirebaseFirestore.instance
//         .collection('userRecords')
//         .where('role', isEqualTo: 'parent')
//         .where('busAssigned', isEqualTo: 'bus 2')
//         .where('email', isEqualTo: user!.email)
//         .limit(1)
//         .get();

//     if (snapshot.docs.isNotEmpty) {
//       final doc = snapshot.docs.first;
//       final pickupPoint = doc['pickuppoint'] as GeoPoint;
//       final latitude = pickupPoint.latitude;
//       final longitude = pickupPoint.longitude;

//       PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         "AIzaSyC7Of1-Po6ADavFd6jgz8VvxEB5mUXvDGo",
//         PointLatLng(destination!.latitude, destination.longitude),
//         PointLatLng(latitude, longitude), // Use the fetched pickup point
//         travelMode: TravelMode.driving,
//       );

//       if (result.status == "OK") {
//         setState(() {
//           polylineCoordinates.clear();
//           result.points.forEach((PointLatLng point) {
//             polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//           });

//           PolylineId id = PolylineId("poly");
//           Polyline polyline = Polyline(
//             polylineId: id,
//             width:2,
//             color: Colors.red,
//             points: polylineCoordinates,
//           );
//           polylines.clear();
//           polylines[id] = polyline;
//         });
//       }
//     } else {
//       // No matching document found
//       print('No matching document found');
//     }
//   } catch (e) {
//     // Error occurred while fetching data
//     print('Error fetching pickup point: $e');
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<Set<Marker>>(
//         stream: getPickupPointsStream(),
//         builder: (BuildContext context, AsyncSnapshot<Set<Marker>> snapshot) {
//           if (snapshot.hasData) {
//             final pickupPoints = snapshot.data!;
//             return GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(-6.7725830, 39.2408590),
//                 zoom: 18,
//               ),
//               markers: pickupPoints.union(markers),
//               polylines: Set<Polyline>.of(polylines.values),
//               onMapCreated: (controller) {
//                 _mapController = controller;
//               },
//             );
//           }
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//           return Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     locationRef?.onValue.drain();
//     super.dispose();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class TrackBus extends StatefulWidget {
  const TrackBus({Key? key}) : super(key: key);

  @override
  State<TrackBus> createState() => _TrackBusState();
}

class _TrackBusState extends State<TrackBus> {
  GoogleMapController? _mapController;
  DatabaseReference? locationRef;
  Set<Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

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
                  infoWindow: InfoWindow(title: "bus"),
                  markerId: MarkerId('bus'),
                  position: LatLng(latitude, longitude),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen,
                  ),
                ),
              );
              _getPolyline(destination: LatLng(latitude, longitude));

              // Adjust the camera's target based on bus location
              _mapController?.animateCamera(
                CameraUpdate.newLatLngZoom(
                  LatLng(latitude, longitude),
                  18.0,
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
        .where('email', isEqualTo: user!.email)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs
          .map((doc) {
            final geoPoint = doc['pickuppoint'] as GeoPoint?;
            final isAbsent = doc['isAbsent'] as bool?;
            if (geoPoint != null && isAbsent != null) {
              return Marker(
                markerId: MarkerId(geoPoint.toString()),
                infoWindow: InfoWindow(title: "Pickuppoint"),
                position: LatLng(geoPoint.latitude, geoPoint.longitude),
                icon: isAbsent
                    ? BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed)
                    : BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue),
              );
            } else {
              return null;
            }
          })
          .whereType<Marker>()
          .toSet();
    });
  }

  Future<void> _getPolyline({LatLng? destination, LatLng? origin}) async {
    try {
      auth.User? user = auth.FirebaseAuth.instance.currentUser;
      final snapshot = await FirebaseFirestore.instance
          .collection('userRecords')
          .where('role', isEqualTo: 'parent')
          .where('busAssigned', isEqualTo: 'bus 2')
          .where('email', isEqualTo: user!.email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        final pickupPoint = doc['pickuppoint'] as GeoPoint;
        final latitude = pickupPoint.latitude;
        final longitude = pickupPoint.longitude;

        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          "AIzaSyC7Of1-Po6ADavFd6jgz8VvxEB5mUXvDGo",
          PointLatLng(destination!.latitude, destination.longitude),
          PointLatLng(latitude, longitude), // Use the fetched pickup point
          travelMode: TravelMode.driving,
        );

        if (result.status == "OK") {
          setState(() {
            polylineCoordinates.clear();
            result.points.forEach((PointLatLng point) {
              polylineCoordinates.add(LatLng(point.latitude, point.longitude));
            });

            PolylineId id = PolylineId("poly");
            Polyline polyline = Polyline(
              polylineId: id,
              width: 2,
              color: Colors.red,
              points: polylineCoordinates,
            );
            polylines.clear();
            polylines[id] = polyline;
          });
        }
      } else {
        // No matching document found
        print('No matching document found');
      }
    } catch (e) {
      // Error occurred while fetching data
      print('Error fetching pickup point: $e');
    }
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
              polylines: Set<Polyline>.of(polylines.values),
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
