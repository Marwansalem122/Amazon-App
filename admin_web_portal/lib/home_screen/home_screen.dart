import 'dart:async';

import 'package:admin_web_portal/common/utils/const.dart';
import 'package:admin_web_portal/common/utils/size_config.dart';
import 'package:admin_web_portal/sellers/blocked_seller_screen.dart';
import 'package:admin_web_portal/sellers/verified_seller_screen.dart';
import 'package:admin_web_portal/users/blocked_user_screen.dart';
import 'package:admin_web_portal/users/verified_users_screen.dart';
import 'package:admin_web_portal/widgets/nav_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String liveTime = "";
  String liveDate = "";

  String formatCurrentLiveTime(DateTime time) {
    return DateFormat("hh:mm:ss a").format(time);
  }

  String formatCurrentLiveDate(DateTime time) {
    return DateFormat("dd MMMM, yyyy").format(time);
  }

  getCurrentLiveTimeDate() {
    liveTime = formatCurrentLiveTime(DateTime.now());
    liveDate = formatCurrentLiveDate(DateTime.now());

    setState(() {
      liveTime;
      liveDate;
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(
        const Duration(seconds: 1), (timer) => getCurrentLiveTimeDate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: NavAppBar(title: "iShop"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("$liveTime\n$liveDate",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                  )),
            ),

            //users active & block accounts button UI
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //active
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const VerifiedUsersScreen()));
                  },
                  child: Image.asset(
                    images["verified_users"]!,
                    width: SizeConfig.screenWidth! * 0.2,
                    height: SizeConfig.screenHeight! * 0.2,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth! * 0.1,
                ),
                //block
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BlockedUsersScreen()));
                  },
                  child: Image.asset(
                    images["blocked_users"]!,
                    width: SizeConfig.screenWidth! * 0.2,
                    height: SizeConfig.screenHeight! * 0.2,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.3,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.03,
            ),
            //sellers active & block accounts button UI
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //active
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const VerifiedSellersScreen()));
                  },
                  child: Image.asset(
                    images["verified_seller"]!,
                    width: SizeConfig.screenWidth! * 0.2,
                    height: SizeConfig.screenHeight! * 0.2,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth! * 0.1,
                ),
                //block
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BlockedSellerersScreen()));
                  },
                  child: Image.asset(
                    images["blocked_seller"]!,
                    width: SizeConfig.screenWidth! * 0.2,
                    height: SizeConfig.screenHeight! * 0.2,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
