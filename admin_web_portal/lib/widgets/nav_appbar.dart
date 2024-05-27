import 'package:admin_web_portal/auth/auth.dart';
import 'package:admin_web_portal/auth/login_screen.dart';
import 'package:admin_web_portal/home_screen/home_screen.dart';
import 'package:admin_web_portal/sellers/sellers_pi_chart_screen.dart';
import 'package:admin_web_portal/users/users_pi_chart_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavAppBar extends StatefulWidget implements PreferredSizeWidget {
  PreferredSizeWidget? preferredSizeWidget;
  String? sellerUid;
  String title;

  NavAppBar(
      {super.key,
      this.preferredSizeWidget,
      this.sellerUid,
      required this.title});

  @override
  State<NavAppBar> createState() => _NavAppBarState();
  @override
  // ignore: unnecessary_null_comparison, recursive_getters
  Size get preferredSize =>
      preferredSizeWidget?.preferredSize ?? const Size(56, kToolbarHeight);
}

class _NavAppBarState extends State<NavAppBar> {
  AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.pinkAccent,
            Colors.deepPurpleAccent,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        )),
      ),
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
        child: Text(widget.title,
            style: const TextStyle(
                fontSize: 26,
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
              child: const Text("Home", style: TextStyle(color: Colors.white))),
        ),
        const Text("|", style: TextStyle(color: Colors.white)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SellersPiChartScreen()));
              },
              child: const Text("Sellers Piechart",
                  style: TextStyle(color: Colors.white))),
        ),
        const Text("|", style: TextStyle(color: Colors.white)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UsersPiChartScreen()));
              },
              child: const Text("Users Piechart",
                  style: TextStyle(color: Colors.white))),
        ),
        const Text("|", style: TextStyle(color: Colors.white)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                _authController.logout();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
              },
              child:
                  const Text("Logout", style: TextStyle(color: Colors.white))),
        ),
      ],
    );
  }
}
