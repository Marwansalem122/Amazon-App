import 'package:admin_web_portal/widgets/nav_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UsersPiChartScreen extends StatefulWidget {
  const UsersPiChartScreen({super.key});

  @override
  State<UsersPiChartScreen> createState() => _UsersPiChartScreenState();
}

class _UsersPiChartScreenState extends State<UsersPiChartScreen> {
  int totalNumberOfVerifiedUsers = 0, totalNumberOfBlockedUsers = 0;
  final List<PieChartSectionData> list = [];

  gettotalNumberOfVerifiedUsers() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("status", isEqualTo: "approved")
        .get()
        .then((allVerifiedSellers) {
      setState(() {
        totalNumberOfVerifiedUsers = allVerifiedSellers.docs.length;
      });
    });
    print(totalNumberOfVerifiedUsers);
  }

  gettotalNumberOfBlockedUsers() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("status", isEqualTo: "not approved")
        .get()
        .then((allBlockedSellers) {
      setState(() {
        totalNumberOfBlockedUsers = allBlockedSellers.docs.length;
      });
    });
    print(totalNumberOfBlockedUsers);
  }

  @override
  void initState() {
    super.initState();
    gettotalNumberOfVerifiedUsers();
    gettotalNumberOfBlockedUsers();
    // final dataBlockedSellers = PieChartSectionData(
    //   color: Colors.red,
    //   value: totalNumberOfBlockedUsers.toDouble(),
    //   radius: 40.0,
    //   title: 'Blocked Sellers',
    // );
    // final dataVerifiededSellers = PieChartSectionData(
    //   color: Colors.red,
    //   value: totalNumberOfVerifiedUsers.toDouble(),
    //   radius: 40.0,
    //   title: 'Verified Sellers',
    // );
    // list.add(dataBlockedSellers);
    // list.add(dataVerifiededSellers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: NavAppBar(title: "iShop"),
        body: PieChart(PieChartData(
          sectionsSpace: 50,
          
          sections: [
            PieChartSectionData(
              color: Colors.pinkAccent,
              value: totalNumberOfBlockedUsers.toDouble(),
              radius: 100,
              title: 'Blocked Users',
            ),
            PieChartSectionData(
              color: Colors.purpleAccent,
              value: totalNumberOfVerifiedUsers.toDouble(),
              radius: 100,
              title: 'Verified Users',
            )
          ],
          centerSpaceRadius:100,
        )));
  }
}