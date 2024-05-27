import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sellers_app/orders_screen/status_banner_widget.dart';
import '../common/utils/const.dart';
import '../models/address.dart';
import 'address_design_widget.dart';

// ignore: must_be_immutable
class OrderDetailsScreen extends StatefulWidget {
  String? orderID;

  OrderDetailsScreen({super.key, required this.orderID});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String orderStatus = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: FirebaseFirestore.instance

                .collection("orders")
                .doc(widget.orderID)
                .get(),
            builder: ((context, AsyncSnapshot dataSnapshot) {
              Map? orderDataMap;
              if (dataSnapshot.hasData) {
                orderDataMap = dataSnapshot.data.data() as Map<String, dynamic>;
                orderStatus = orderDataMap["status"].toString();
                return Column(
                  children: [
                    StatusBanner(
                      status: orderDataMap["isSuccess"],
                      orderStatus: orderStatus,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "\$${orderDataMap["totalAmount"]}",
                          style: TextStyle(
                              fontSize: 24.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Order ID: ${orderDataMap["orderID"]}",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Order at: ${DateFormat("dd MMM, yyyy - hh:mm aa").format(DateTime.fromMillisecondsSinceEpoch(int.parse(orderDataMap["orderTime"])))}",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.pinkAccent,
                    ),
                    orderStatus == "ended"
                        ? Image.asset(images["packing"]!)
                        : Image.asset(images["delivered"]!),
                    const Divider(
                      thickness: 2,
                      color: Colors.pinkAccent,
                    ),
                    FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("users")
                            .doc(orderDataMap["orderBy"])
                            .collection("userAddress")
                            .doc(orderDataMap["addressID"])
                            .get(),
                        builder: (context, AsyncSnapshot dataSnapShot) {
                          if (dataSnapShot.hasData) {
                            return AddressDesignWidget(
                              model: Address.fromJson(dataSnapShot.data.data()
                                  as Map<String, dynamic>),
                              orderId: widget.orderID,
                              orderStatus: orderStatus,
                              sellerId: orderDataMap!["sellerUID"],
                              orderByUser: orderDataMap["orderBy"],
                              totalAmount:orderDataMap["totalAmount"].toString()
                            );
                          } else {
                            return const Center(
                              child: Text("No Data Exist"),
                            );
                          }
                        })
                  ],
                );
              } else {
                return const Center(
                  child: Text("No Data Exist"),
                );
              }
            })),
      ),
    );
  }
}
