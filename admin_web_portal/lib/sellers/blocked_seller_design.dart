import 'package:admin_web_portal/common/utils/const.dart';
import 'package:admin_web_portal/common/widgets/flutter_toast.dart';
import 'package:admin_web_portal/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget blockededSellerDesignWidget(
    QuerySnapshot? allBlockedSellers, BuildContext context) {
  return allBlockedSellers == null
      ? const Center(
          child: Text("No Sellers Verified", style: TextStyle(fontSize: 30)))
      : ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: allBlockedSellers.docs.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 180,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            allBlockedSellers.docs[index].get("photoUrl"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    allBlockedSellers.docs[index].get("name"),
                  ),
                  Text(
                    allBlockedSellers.docs[index].get("email"),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // showDialogBox(allApprovedUsers!.docs[index].id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            images["activate"]!,
                            width: 56,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialogBox(
                                  allBlockedSellers.docs[index].id, context);
                            },
                            child: const Text(
                              "Activate Now",
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
}

showDialogBox(sellerDocumentId, BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Active Account",
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Do you want to activate this account ?",
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> sellerDataMap = {
                  "status": "approved",
                };

                FirebaseFirestore.instance
                    .collection("sellers")
                    .doc(sellerDocumentId)
                    .update(sellerDataMap)
                    .whenComplete(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const HomeScreen()));

                  toastMessage(msg: "Activated Successfully.");
                });
              },
              child: const Text("Yes"),
            )
          ],
        );
      });
}
