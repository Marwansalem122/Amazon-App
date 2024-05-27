import 'package:admin_web_portal/common/utils/const.dart';
import 'package:admin_web_portal/common/widgets/flutter_toast.dart';
import 'package:admin_web_portal/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget blockededUserDesignWidget(
    QuerySnapshot? allBlockedUsers, BuildContext context) {
  return allBlockedUsers == null
      ? const Center(
          child: Text("No Record Found.", style: TextStyle(fontSize: 30)))
      : ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: allBlockedUsers.docs.length,
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
                            allBlockedUsers.docs[index].get("photoUrl"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    allBlockedUsers.docs[index].get("name"),
                  ),
                  Text(
                    allBlockedUsers.docs[index].get("email"),
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
                                  allBlockedUsers.docs[index].id, context);
                            },
                            child: const Text(
                              "Active Now",
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

showDialogBox(userDocumentId, BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Activate Accoun Account",
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Do you want to active this account ?",
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
                Map<String, dynamic> userDataMap = {
                  "status": "approved",
                };

                FirebaseFirestore.instance
                    .collection("users")
                    .doc(userDocumentId)
                    .update(userDataMap)
                    .whenComplete(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const HomeScreen()));

                  toastMessage(msg: "Activate Successfully.");
                });
              },
              child: const Text("Yes"),
            )
          ],
        );
      });
}
