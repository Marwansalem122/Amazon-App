import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:amazonclone/common/utils/const.dart';
import 'package:amazonclone/common/widgets/custom_Elevated_button.dart';
import 'package:amazonclone/common/widgets/flutter_toast.dart';
import 'package:amazonclone/global/global.dart';
import 'package:amazonclone/sellers_screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class PlaceOrderScreen extends StatefulWidget {
  String? sellerUid;
  double? totalAmount;
  String? addressId;

  PlaceOrderScreen({
    Key? key,
    required this.sellerUid,
    required this.totalAmount,
    required this.addressId,
  }) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  String orderId = DateTime.now().millisecondsSinceEpoch.toString();
  orderDetails() {
    saveOrderDetailsForUser({
      "addressID": widget.addressId,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productID": sharedPreferences!.getStringList("userCard"),
      "paymentDetails": "cash on Delivery",
      "orderTime": orderId,
      "orderID": orderId,
      "isSuccess": true,
      "sellerUID": widget.sellerUid,
      "status": "normal",
    }).whenComplete(() {
      saveOrderDetailsForSeller({
        "addressID": widget.addressId,
        "totalAmount": widget.totalAmount,
        "orderBy": sharedPreferences!.getString("uid"),
        "productID": sharedPreferences!.getStringList("userCard"),
        "paymentDetails": "cash on Delivery",
        "orderTime": orderId,
        "orderID": orderId,
        "isSuccess": true,
        "sellerUID": widget.sellerUid,
        "status": "normal",
      }).whenComplete(() {
        cartMethods.clearCart(context);

        //send Notification to seller about new order which placed by user
        sendNotificationToSeller(
            sellerId: widget.sellerUid.toString(), orderId: orderId);
        toastInfo(msg: "Congratulations, order has been placed successfully");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreens()),
            (route) => false);
        orderId = "";
      });
    });
  }

  saveOrderDetailsForUser(Map<String, dynamic> orderDetailsMap) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .set(orderDetailsMap);
  }

  saveOrderDetailsForSeller(Map<String, dynamic> orderDetailsMap) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(orderDetailsMap);
  }

  void sendNotificationToSeller(
      {required String sellerId, required String orderId}) {
    String sellerDeviceToken = "";
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sellerId)
        .get()
        .then((snapshot) {
      if (snapshot.data()!["sellerDeviceToken"] != null) {
        sellerDeviceToken = snapshot.data()!["sellerDeviceToken"].toString();
        // print("Device Token of that Seller = $sellerDeviceToken");
        // print("Order ID of that Seller = $orderId");
      }
    });
    notificationFormate(
        sellerDeviceToken: sellerDeviceToken,
        orderId: orderId,
        userName: sharedPreferences!.getString("name"));
  }

  void notificationFormate(
      {required String sellerDeviceToken,
      required String orderId,
      required String? userName}) {
    Map<String, String> headerNotification = {
      'Content-Type': 'application/json',
      'Authorization': fcmServerToken
    };
    Map bodyNotification = {
      'body':
          "Dear Seller ,New Order (#$orderId) has Placed Successfully from user $userName. \nPlease Check Now.",
      'title': "New Order"
    };
    Map dataMap = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "userOrderId": orderId,
    };

    Map officialNotificationFormat = {
      'notification': bodyNotification,
      'data': dataMap,
      'priority': 'high',
      'to': sellerDeviceToken,
    };

    http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(officialNotificationFormat),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(images["delivery"]!),
          SizedBox(
            height: 30.h,
          ),
          CustomElevatedButton(
              text: "Place Order Now",
              buttonWidth: 180.w,
              buttonheight: 50.h,
              onpressed: () {
                orderDetails();
              },
              color: Colors.pinkAccent,
              textcolor: Colors.white)
        ],
      ),
    );
  }
}
