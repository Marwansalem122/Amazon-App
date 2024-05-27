import 'package:admin_web_portal/common/utils/size_config.dart';
import 'package:admin_web_portal/sellers/verified_seller_design_widger.dart';
import 'package:admin_web_portal/widgets/nav_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VerifiedSellersScreen extends StatefulWidget {
  const VerifiedSellersScreen({super.key});

  @override
  State<VerifiedSellersScreen> createState() => _VerifiedSellersScreenState();
}

class _VerifiedSellersScreenState extends State<VerifiedSellersScreen> {
  QuerySnapshot? allAppprovedSellers;
  getAllVerifiedSellers() async {
   await FirebaseFirestore.instance
        .collection("sellers")
        .where("status", isEqualTo: "approved")
        .get()
        .then((allVerifiedSellers) {
     setState(() {
        allAppprovedSellers = allVerifiedSellers;
     });
    });
    print(allAppprovedSellers);
    return allAppprovedSellers;
  }
  

  @override
  void initState() {
    super.initState();
    getAllVerifiedSellers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavAppBar(title: "verified Sellers Accounts"),
      body: Center(
          child: SizedBox(
              width: SizeConfig.screenWidth! * 0.5,
              child: verifiedSellerrDesignWidget(allAppprovedSellers,context))),
    );
  }


}
