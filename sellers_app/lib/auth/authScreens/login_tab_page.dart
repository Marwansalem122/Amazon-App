import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/utils/const.dart';
import '../../common/widgets/custom_Elevated_button.dart';
import '../../common/widgets/loading_dialog.dart';
import '../../screens/widgets/custom_text_form_field.dart';
import 'package:sellers_app/common/widgets/flutter_toast.dart';
import 'package:sellers_app/auth/auth.dart';

// import'package:sellers_app/common/widgets/loading_dialog.dart';
// import'package:sellers_app/common/widgets/custom_Elevated_button.dart';
class LoginTabScreen extends StatefulWidget {
  const LoginTabScreen({super.key});

  @override
  State<LoginTabScreen> createState() => _LoginTabScreenState();
}

class _LoginTabScreenState extends State<LoginTabScreen> {
  final GlobalKey<FormState> formkey2 =
      GlobalKey<FormState>(debugLabel: '_loginScreenkey');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthHelper _auth = AuthHelper();
  validationForm() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return const LoadingDialog(message: "Checking your Account");
          });
      //allow to seller login
      _auth.signIn(
          emailController.text.trim(), passwordController.text.trim(), context);
    } else {
      toastInfo(msg: "Please provide Email and Passwor");
    }
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          //get image from camera
          Image.asset(
            images["login"]!,
            // width: width * 0.8,
            height: height * 0.35,
          ),
          Form(
            key: formkey2,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomTextFormField(
                hintText: 'Enter your email',
                controller: emailController,
                icon: Icons.email,
                enable: true,
                issecurse: false,
                typefield: 'email',
              ),
              CustomTextFormField(
                hintText: 'Enter your Password',
                controller: passwordController,
                icon: Icons.lock,
                enable: true,
                issecurse: true,
                typefield: 'password',
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(right: 20.w),
            alignment: Alignment.topRight,
            child: InkWell(
              child: const Text(
                "Foreget Password ?",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onTap: () {
                if (emailController.text.isNotEmpty) {
                  _auth.resetPassword(emailController.text);
                } else {
                  toastInfo(msg: "Please Enter Email.");
                }
              },
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          CustomElevatedButton(
            text: "Login",
            buttonWidth: 150,
            buttonheight: 40,
            onpressed: () => validationForm(),
            color: Colors.purple,
            textcolor: Colors.white,
          ),
          SizedBox(
            height: height * 0.04,
          ),
        ],
      ),
    );
  }
}
