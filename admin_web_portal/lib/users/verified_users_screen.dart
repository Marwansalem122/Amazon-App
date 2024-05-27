import 'package:admin_web_portal/common/utils/size_config.dart';
import 'package:admin_web_portal/users/verified_user_design_widger.dart';
import 'package:admin_web_portal/widgets/nav_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VerifiedUsersScreen extends StatefulWidget {
  const VerifiedUsersScreen({super.key});

  @override
  State<VerifiedUsersScreen> createState() => _VerifiedUsersScreenState();
}

class _VerifiedUsersScreenState extends State<VerifiedUsersScreen> {
  QuerySnapshot? allAppprovedUsers;
  getAllVerifiedUsers() async {
   await FirebaseFirestore.instance
        .collection("users")
        .where("status", isEqualTo: "approved")
        .get()
        .then((allVerifiedUsers) {
     setState(() {
        allAppprovedUsers = allVerifiedUsers;
     });
    });
    print(allAppprovedUsers);
    return allAppprovedUsers;
  }
  

  @override
  void initState() {
    super.initState();
    getAllVerifiedUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavAppBar(title: "verified users Accounts"),
      body: Center(
          child: SizedBox(
              width: SizeConfig.screenWidth! * 0.5,
              child: verifiedUserDesignWidget(allAppprovedUsers,context))),
    );
  }


}
