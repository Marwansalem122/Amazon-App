import 'package:admin_web_portal/common/utils/const.dart';
import 'package:admin_web_portal/common/widgets/flutter_toast.dart';
import 'package:admin_web_portal/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget verifiedSellerrDesignWidget(
    QuerySnapshot? allAppprovedSellers, BuildContext context) {
  return allAppprovedSellers == null
      ? const Center(
          child: Text("No Sellers Verified", style: TextStyle(fontSize: 30)))
      : ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: allAppprovedSellers.docs.length,
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
                            allAppprovedSellers.docs[index].get("photoUrl"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    allAppprovedSellers.docs[index].get("name"),
                  ),
                  Text(
                    allAppprovedSellers.docs[index].get("email"),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Block seller
                      GestureDetector(
                        onTap: () {
                          showDialogBox(
                              allAppprovedSellers.docs[index].id, context);
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 18.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                images["blocked_seller"]!,
                                width: 56,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Row(
                                children: [
                                  Text(
                                    "Block Now",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      //earnings
                      GestureDetector(
                        onTap: () {
                          toastMessage(
                              msg:
                                  "Total Earnings: \$ ${allAppprovedSellers.docs[index].get("earnings")}");
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 18.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                images["earnings"]!,
                                width: 56,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$ ${allAppprovedSellers.docs[index].get("earnings")}",
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
            "Block Account",
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Do you want to block this account ?",
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
                  "status": "not approved",
                };

                FirebaseFirestore.instance
                    .collection("sellers")
                    .doc(sellerDocumentId)
                    .update(sellerDataMap)
                    .whenComplete(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const HomeScreen()));

                  toastMessage(msg: "Blocked Successfully.");
                });
              },
              child: const Text("Yes"),
            )
          ],
        );
      });
}
