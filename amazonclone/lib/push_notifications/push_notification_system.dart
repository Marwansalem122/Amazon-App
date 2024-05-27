import 'package:amazonclone/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

//notification arrives/recieves
  Future whenNotificationRecieves() async {
    //1.terminated
    //when the app is completely closed and opened directly from the push notification
    messaging.getInitialMessage().then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //show notification data when open app
      }
    });

    //2.foreground
    //when the app is open and recieve notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //directly show notification data 

      }
    });

    //3.background
    //when the app is in the background and directory from the the push notification
    
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //open the app - directly show notification data 

      }
    });
  }

  //device recognition token
  Future generateRecognitionDeviceToken() async {
    String? recognitionDeviceToken = await messaging.getToken();
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .update({"userDeviceToken": recognitionDeviceToken});
    messaging.subscribeToTopic("allSellers");
    messaging.subscribeToTopic("allUsers");
  }
}
