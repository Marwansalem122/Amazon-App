import 'package:admin_web_portal/common/utils/size_config.dart';
import 'package:admin_web_portal/users/blocked_user_design.dart';
import 'package:admin_web_portal/widgets/nav_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlockedUsersScreen extends StatefulWidget {
  const BlockedUsersScreen({super.key});

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  QuerySnapshot? allBlockedUsers;
  getAllBlockededUsers() async {
   await FirebaseFirestore.instance
        .collection("users")
        .where("status", isEqualTo: "not approved")
        .get()
        .then((getAllBlockedUsers) {
     setState(() {
        allBlockedUsers = getAllBlockedUsers;
     });
    });
    print(allBlockedUsers);
    return allBlockedUsers;
  }
  

  @override
  void initState() {
    super.initState();
    getAllBlockededUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavAppBar(title: "Blocked users Accounts"),
      body: Center(
          child: SizedBox(
              width: SizeConfig.screenWidth! * 0.5,
              child: blockededUserDesignWidget(allBlockedUsers,context))),
    );
  }


}
