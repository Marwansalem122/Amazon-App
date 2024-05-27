import 'package:admin_web_portal/common/widgets/flutter_toast.dart';
import 'package:admin_web_portal/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController {
 final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void login(
      {required email,
      required String password,
      required BuildContext context}) async {
    try {
      User? currentAdmin;
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        currentAdmin = value.user!;
      });
      //check if admin exist in database
      await _firestore
          .collection("admins")
          .doc(currentAdmin!.uid)
          .get()
          .then((snapshot) {
        if (snapshot.exists) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false);
        } else {
          toastMessage(
              msg: "No record found , you aren't Admin.",
              backgroundColor: Colors.red);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toastMessage(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        toastMessage(msg: 'Wrong password provided for that user.');
      } else {
        toastMessage(msg: "Error Occured $e");
        print("Error is: $e");
      }
    }
  }

  void logout() async {
    await _auth.signOut();
  }
}
