import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/screens/splashScreen/splashview_page.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  String totalSellerEarnings = "";
  readTotalEarnings() async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snap) {
      setState(() {
        totalSellerEarnings = snap.data()!["earnings"].toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    readTotalEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("\$ $totalSellerEarnings",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold)),
            Text("Total Earnings",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.sp,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold)),
                    
            SizedBox(
              height: 20.h,
              width: 200.w,
              child: const Divider(
                color: Colors.white,
                thickness: 1.5,
              ),
            ),
            SizedBox(height: 40.h),
            Card(
              color: Colors.white54,
              margin: EdgeInsets.symmetric(horizontal: 120.w, vertical: 40.h),
              child: ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MySplashScreen())),
                leading: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                title: Text("Go Back",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            )
          ],
        ),
      )),
    );
  }
}
