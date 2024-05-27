import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sellers_app/common/widgets/flutter_toast.dart';
import 'package:sellers_app/global/global.dart';

class PushNotificationsSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

//notification arrives/recieves
  Future whenNotificationRecieves(BuildContext context) async {
    //1.terminated
    //when the app is completely closed and opened directly from the push notification
   FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //show notification data when open app
        showNotificationWhenOpenApp(
          orderId: remoteMessage.data["userOrderId"],
          context: context,
        );
      }
    });

    //2.foreground
    //when the app is open and recieve notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //directly show notification data
        showNotificationWhenOpenApp(
          orderId: remoteMessage.data["userOrderId"],
          context: context,
        );
      }
    });

    //3.background
    //when the app is in the background and directory from the the push notification

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //open the app - directly show notification data
        showNotificationWhenOpenApp(
          orderId: remoteMessage.data["userOrderId"],
          context: context,
        );
      }
    });
  }

  //device recognition token
  Future generateRecognitionDeviceToken() async {
    String? recognitionDeviceToken = await messaging.getToken();
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .update({"sellerDeviceToken": recognitionDeviceToken});
    messaging.subscribeToTopic("allSellers");
    messaging.subscribeToTopic("allUsers");
  }

  void showNotificationWhenOpenApp(
      {required orderId, required BuildContext context}) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .get()
        .then((snapshot) {
      if (snapshot.data()!["status"] == "ended") {
        toastInfo(
            msg:
                "OrderID : #$orderId\n\n has delivered & received by the user.");
      } else {
        toastInfo(
            msg:
                "You have Neworder. \nOrderID : #$orderId\n\n Please Check now.");
      }
    });
  }
}
