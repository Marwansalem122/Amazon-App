import 'package:admin_web_portal/widgets/nav_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SellersPiChartScreen extends StatefulWidget {
  const SellersPiChartScreen({super.key});

  @override
  State<SellersPiChartScreen> createState() => _SellersPiChartScreenState();
}

class _SellersPiChartScreenState extends State<SellersPiChartScreen> {
  int totalNumberOfVerifiedSellers = 0, totalNumberOfBlockedSellers = 0;
  final List<PieChartSectionData> list = [];

  getTotalNumberOfVerifiedSellers() async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .where("status", isEqualTo: "approved")
        .get()
        .then((allVerifiedSellers) {
      setState(() {
        totalNumberOfVerifiedSellers = allVerifiedSellers.docs.length;
      });
    });
    print(totalNumberOfVerifiedSellers);
  }

  getTotalNumberOfBlockedSellers() async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .where("status", isEqualTo: "not approved")
        .get()
        .then((allBlockedSellers) {
      setState(() {
        totalNumberOfBlockedSellers = allBlockedSellers.docs.length;
      });
    });
    print(totalNumberOfBlockedSellers);
  }

  @override
  void initState() {
    super.initState();
    getTotalNumberOfVerifiedSellers();
    getTotalNumberOfBlockedSellers();
    // final dataBlockedSellers = PieChartSectionData(
    //   color: Colors.red,
    //   value: totalNumberOfBlockedSellers.toDouble(),
    //   radius: 40.0,
    //   title: 'Blocked Sellers',
    // );
    // final dataVerifiededSellers = PieChartSectionData(
    //   color: Colors.red,
    //   value: totalNumberOfVerifiedSellers.toDouble(),
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
              value: totalNumberOfBlockedSellers.toDouble(),
              radius: 100,
              title: 'Blocked Sellers',
            ),
            PieChartSectionData(
              color: Colors.purpleAccent,
              value: totalNumberOfVerifiedSellers.toDouble(),
              radius: 100,
              title: 'Verified Sellers',
            )
          ],
          centerSpaceRadius:100,
        )));
  }
}

/*

import 'package:admin_web_portal/widgets/nav_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SellersPiChartScreen extends StatefulWidget {
  const SellersPiChartScreen({super.key});

  @override
  State<SellersPiChartScreen> createState() => _SellersPiChartScreenState();
}

class _SellersPiChartScreenState extends State<SellersPiChartScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<PieChartSectionData> _pieChartSections = [];

  Future<void> _loadSellersData() async {
    try {
      final sellersSnapshot = await _firestore.collection("sellers").get();
      final verifiedSellers = sellersSnapshot.docs.where((doc) => doc["status"] == "approved").length;
      final blockedSellers = sellersSnapshot.docs.where((doc) => doc["status"] == "not approved").length;

      setState(() {
        _pieChartSections = [
          PieChartSectionData(
            color: Colors.red,
            value: blockedSellers.toDouble(),
            radius: 40.0,
            title: 'Blocked Sellers',
          ),
          PieChartSectionData(
            color: Colors.green,
            value: verifiedSellers.toDouble(),
            radius: 40.0,
            title: 'Verified Sellers',
          ),
        ];
      });
    } catch (e) {
      print("Error loading sellers data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: NavAppBar(title: "iShop"),
      body: FutureBuilder(
        future: _loadSellersData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading data"));
          } else {
            return AspectRatio(
              aspectRatio: 1.0,
              child: PieChart(PieChartData(
                sections: _pieChartSections,
                centerSpaceRadius: 48.0,
              )),
            );
          }
        },
      ),
    );
  }
}
*/