import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:school_bus_tracking_management_system_admin_module/authentication/usermodal.dart';

import '../user_management/database.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

//Function for user(admin) to login to the system
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

//Function for user to logout of the system
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

//Function for Admin to register in to the system

  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return _userFromFirebase(credential.user);
  }

//Function to register driver into the system
  Future<User?> createDriverWithEmailAndPassword(
      {required String firstName,
      required String lastName,
      required String licenseNo,
      required String contact,
      required String email,
      required String password,
      required String busAssigned}) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    await UserDatabaseService(uid: credential.user!.uid).createDriverRecord(
        busAssigned: busAssigned,
        contact: contact,
        email: email,
        firstName: firstName,
        lastName: lastName,
        licenseNo: licenseNo,
        password: password);
    return _userFromFirebase(credential.user);
  }

//Function to register parent and student

  Future<User?> createParentWithEmailAndPassword(
      {required String firstName,
      required String lastName,
      required String contact,
      required String email,
      required String password,
      required String studentFname,
      required String studentLname,
      required String studentClass,
      required String residence,
      required String pickuppoint,
      required String busAssigned}) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    await UserDatabaseService(uid: credential.user!.uid).createParentRecord(
       
        firstName:firstName,
        lastName:lastName,
        contact:contact,
        email:email,
        password:password,
        studentFname:studentFname,
        studentLname:studentLname,
        studentClass:studentClass,
        residence:residence,
        pickuppoint:pickuppoint,
        busAssigned:busAssigned
      




    );
    return _userFromFirebase(credential.user);
  }
}
