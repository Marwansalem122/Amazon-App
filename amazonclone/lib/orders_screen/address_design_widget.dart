import 'package:amazonclone/common/widgets/flutter_toast.dart';
import 'package:amazonclone/models/address.dart';
import 'package:amazonclone/rating_screen/rate_seller_screen.dart';
import 'package:amazonclone/sellers_screens/splashview/splashview_page.dart';
import 'package:amazonclone/widgets/common_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AddressDesignWidget extends StatelessWidget {
  Address? model;
  String? orderStatus;
  String? orderId;
  String? sellerId;
  String? orderByUser;
  AddressDesignWidget(
      {super.key,
      required this.model,
      required this.orderId,
      required this.orderStatus,
      required this.sellerId,
      required this.orderByUser});

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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MySplashScreen()));
            } else if (orderStatus == "shifted") {
              //implement Parcel  Recieved feature
              FirebaseFirestore.instance
                  .collection("orders")
                  .doc(orderId)
                  .update({"status": "ended"}).whenComplete(() {
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(orderByUser)
                    .collection("orders")
                    .doc(orderId)
                    .update({"status": "ended"});
                //send Notification to seller
                toastInfo(msg: "Confirmed Successfully.");
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MySplashScreen()));
              });
            } else if (orderStatus == "ended") {
              //implement Rate This Seller feature
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RateSellerScreen(
                        sellerId: sellerId!,
                      )));
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
                      ? "Do you want to Rate This Seller?"
                      : orderStatus == "shifted"
                          ? "Parcel Delivered, \nClick to Confirm"
                          : orderStatus == "normal"
                              ? "Go Back"
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
