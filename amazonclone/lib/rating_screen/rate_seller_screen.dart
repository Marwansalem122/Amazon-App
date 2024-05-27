import 'package:amazonclone/common/widgets/custom_Elevated_button.dart';
import 'package:amazonclone/common/widgets/flutter_toast.dart';
import 'package:amazonclone/global/global.dart';
import 'package:amazonclone/sellers_screens/splashview/splashview_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

// ignore: must_be_immutable
class RateSellerScreen extends StatefulWidget {
  final String sellerId;
  const RateSellerScreen({super.key, required this.sellerId});

  @override
  State<RateSellerScreen> createState() => _RateSellerScreenState();
}

class _RateSellerScreenState extends State<RateSellerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Dialog(
        backgroundColor: Colors.white60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          margin: const EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6), color: Colors.white54),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 22.h,
              ),
              Text(
                "Rate This Seller",
                style: TextStyle(
                    fontSize: 22.sp,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 22.h,
              ),
              Divider(
                height: 4.h,
                thickness: 4,
              ),
              SizedBox(
                height: 22.h,
              ),
              SmoothStarRating(
                rating: countStarsRating,
                allowHalfRating: true,
                starCount: 5,
                color: Colors.purpleAccent,
                borderColor: Colors.purpleAccent,
                size: 46,
                onRatingChanged: (valueOfStarsChoosed) {
                  countStarsRating = valueOfStarsChoosed;
                  if (countStarsRating > 0 && countStarsRating <= 1.5) {
                    setState(() {
                      titleStarsRating = "Very Bad";
                    });
                  } else if (countStarsRating > 1.5 &&
                      countStarsRating <= 2.5) {
                    setState(() {
                      titleStarsRating = "Bad";
                    });
                  } else if (countStarsRating > 2.5 &&
                      countStarsRating <= 3.5) {
                    setState(() {
                      titleStarsRating = "Good";
                    });
                  } else if (countStarsRating > 3.5 &&
                      countStarsRating <= 4.5) {
                    setState(() {
                      titleStarsRating = "Very Good";
                    });
                  } else if (countStarsRating == 5) {
                    setState(() {
                      titleStarsRating = "Excellent";
                    });
                  }
                },
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(titleStarsRating,
                  style: TextStyle(
                      fontSize: 30.sp,
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 18.h,
              ),
              CustomElevatedButton(
                  text: "Submit",
                  buttonWidth: 210.w,
                  buttonheight: 40.h,
                  onpressed: () {
                    FirebaseFirestore.instance
                        .collection("sellers")
                        .doc(widget.sellerId)
                        .get()
                        .then((snap) {
                      if (snap.data()!["ratings"] == null) {
                        //seller not yet recieve rate from any user
                        FirebaseFirestore.instance
                            .collection("sellers")
                            .doc(widget.sellerId)
                            .update({
                          "ratings":
                              (countStarsRating.toStringAsFixed(1)).toString()
                        });
                      }
                      //seller already recieve rate from any user
                      else {
                        double pastRatings =
                            double.parse(snap.data()!["ratings"]);
                        double newRatings =
                            ((pastRatings + countStarsRating) / 2);
                        FirebaseFirestore.instance
                            .collection("sellers")
                            .doc(widget.sellerId)
                            .update({
                          "ratings": (newRatings.toStringAsFixed(1)).toString()
                        });
                      }
                      toastInfo(msg: "Rated Successfully.");
                      setState(() {
                        countStarsRating = 0.0;
                        titleStarsRating = "";
                      });
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MySplashScreen()));
                    });
                  },
                  color: Colors.purpleAccent,
                  textcolor: Colors.white),
              SizedBox(
                height: 18.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
