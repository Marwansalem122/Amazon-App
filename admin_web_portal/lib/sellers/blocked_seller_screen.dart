import 'package:admin_web_portal/common/utils/size_config.dart';
import 'package:admin_web_portal/sellers/blocked_seller_design.dart';
import 'package:admin_web_portal/widgets/nav_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlockedSellerersScreen extends StatefulWidget {
  const BlockedSellerersScreen({super.key});

  @override
  State<BlockedSellerersScreen> createState() => _BlockedSellerersScreenState();
}

class _BlockedSellerersScreenState extends State<BlockedSellerersScreen> {
  QuerySnapshot? allBlockedSellers;
  getAllBlockededsellers() async {
   await FirebaseFirestore.instance
        .collection("sellers")
        .where("status", isEqualTo: "not approved")
        .get()
        .then((getallBlockedSellers) {
     setState(() {
        allBlockedSellers = getallBlockedSellers;
     });
    });
    print(allBlockedSellers);
    return allBlockedSellers;
  }
  

  @override
  void initState() {
    super.initState();
    getAllBlockededsellers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavAppBar(title: "Blocked Sellers Accounts"),
      body: Center(
          child: SizedBox(
              width: SizeConfig.screenWidth! * 0.5,
              child: blockededSellerDesignWidget(allBlockedSellers,context))),
    );
  }


}
