import 'package:amazonclone/orders_screen/order_card.dart';
import 'package:amazonclone/widgets/common_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../global/global.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() =>
      _HistoryScreenState();
}

class _HistoryScreenState
    extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: commonContainer(child: Container()),
        title: const Text("Parcels History"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("status", isEqualTo: "ended")
            .where("orderBy", isEqualTo: sharedPreferences!.getString("uid"))
            .orderBy("orderTime", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot datasnapshot) {
          if (datasnapshot.hasData) {
            //Display
            print("datasnap-------------------");
            return ListView.builder(
                itemCount: datasnapshot.data.docs.length,
                itemBuilder: (c, index) {
                  return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection("items")
                          .where("itemId",
                              whereIn: cartMethods.separateOrderIDs(
                                  (datasnapshot.data.docs[index].data()
                                      as Map<String, dynamic>)["productID"]))
                          .where("orderBy",
                              whereIn: (datasnapshot.data.docs[index].data()
                                  as Map<String, dynamic>)["uid"])
                          .orderBy("publishedDate", descending: true)
                          .get(),
                      builder: (c, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          print("sanap-------------------");
                          return OrderCard(
                              itemCount: snapshot.data.docs.length,
                              data: snapshot.data.docs,
                              orderID: datasnapshot.data.docs[index].id,
                              seperateQuantitiesList: cartMethods
                                  .separateordersQuantities((datasnapshot
                                          .data.docs[index]
                                          .data()
                                      as Map<String, dynamic>)["productID"]));
                        } else {
                          return const Center(
                            child: Text(
                              "No data exist.",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                      });
                });
          } else {
            return const Center(
              child: Text(
                "No data exist.",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
