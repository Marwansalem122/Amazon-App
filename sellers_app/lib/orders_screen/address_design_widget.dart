import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sellers_app/common/widgets/flutter_toast.dart';
import 'package:sellers_app/global/global.dart';
import '../models/address.dart';
import '../screens/splashScreen/splashview_page.dart';
import '../screens/widgets/common_widgets.dart';

// ignore: must_be_immutable
class AddressDesignWidget extends StatelessWidget {
  Address? model;
  String? orderStatus;
  String? orderId;
  String? sellerId;
  String? orderByUser;
  String? totalAmount;
  AddressDesignWidget(
      {super.key,
      required this.model,
      required this.orderId,
      required this.orderStatus,
      required this.sellerId,
      required this.orderByUser,
      required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Shopping Details",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 50.w),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              //Name
              TableRow(children: [
                const Text("Name", style: TextStyle(color: Colors.grey)),
                Text(model!.name.toString(),
                    style: const TextStyle(color: Colors.grey))
              ])
              //Phone Number
              ,
              TableRow(children: [
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  height: 5.h,
                ),
              ]),
              TableRow(children: [
                const Text("Phone Number",
                    style: TextStyle(color: Colors.grey)),
                Text(model!.phoneNumber.toString(),
                    style: const TextStyle(color: Colors.grey))
              ]),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            model!.completeAddress.toString(),
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (orderStatus == "normal") {
              //update earnings
              FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(sharedPreferences!.getString("uid"))
                  .update({
                "earnings": (double.parse(previousEarning)) +
                    (double.parse(totalAmount!))
              }).whenComplete(() {
                //change order status to shifted
                FirebaseFirestore.instance
                    .collection("orders")
                    .doc(orderId)
                    .update({"status": "shifted"}).whenComplete(() {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(orderByUser)
                      .collection("orders")
                      .doc(orderId)
                      .update({"status": "shifted"}).whenComplete(() {
                    //send Notifications to user -order shifte
                    toastInfo(msg: "Confirmed Successfully.");
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) =>const MySplashScreen()));
                  });
                });
              });
            } else if (orderStatus == "shifted") {
              //implement Parcel Delivered & Recieved feature
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MySplashScreen()));
            } else if (orderStatus == "ended") {
              //implement Rate This Seller feature
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MySplashScreen()));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MySplashScreen()));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: orderStatus == "ended"
                  ? 50.h
                  : MediaQuery.of(context).size.height * 0.1,
              child: commonContainer(
                  child: Center(
                child: Text(
                  orderStatus == "ended"
                      ? "Go back"
                      : orderStatus == "shifted"
                          ? "Go back"
                          : orderStatus == "normal"
                              ? "Parcel Delivered & Recieved\nClick to Confirm"
                              : "",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              )),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}
