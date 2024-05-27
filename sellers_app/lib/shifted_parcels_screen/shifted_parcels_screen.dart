import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sellers_app/orders_screen/order_card.dart';
import '../global/global.dart';
import '../screens/widgets/common_widgets.dart';

class ShiftedParcelsScreen extends StatefulWidget {
  const ShiftedParcelsScreen({super.key});

  @override
  State<ShiftedParcelsScreen> createState() => _ShiftedParcelsScreenState();
}

class _ShiftedParcelsScreenState extends State<ShiftedParcelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: commonContainer(child: Container()),
        title: const Text("Shifted Parcels Screen"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("status", isEqualTo: "shifted")
            .where("sellerUID", isEqualTo: sharedPreferences!.getString("uid"))
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
                          .where("sellerUID",
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
