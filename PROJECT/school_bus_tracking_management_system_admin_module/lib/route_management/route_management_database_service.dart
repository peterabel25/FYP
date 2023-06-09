// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference routeCollection =
      FirebaseFirestore.instance.collection('route');

      final CollectionReference busCollection =
      FirebaseFirestore.instance.collection('bus');


  Future RegisterRoute(
      String routeName, String startPoint, String endPoint) async {
    return await routeCollection.doc(routeName).set({
      'startPoint':startPoint,
      'endPoint':endPoint
    });
  }

  Future RegisterBus(
      String busNo, String plateNo, String routeAssigned,
      ) async {
    return await busCollection.doc(busNo).set({
      'plateNo':plateNo,
      'routeAssigned':routeAssigned,
      //'driverAssigned':driverAssigned
    });
  }
}
