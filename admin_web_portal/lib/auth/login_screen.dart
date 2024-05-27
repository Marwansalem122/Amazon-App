import 'package:admin_web_portal/auth/auth.dart';
import 'package:admin_web_portal/common/utils/const.dart';
import 'package:admin_web_portal/common/utils/size_config.dart';
import 'package:admin_web_portal/common/widgets/custom_Elevated_button.dart';
import 'package:admin_web_portal/common/widgets/flutter_toast.dart';
import 'package:admin_web_portal/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthController _authController = AuthController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: SizeConfig.screenWidth! * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    images["admin"]!,
                    width: SizeConfig.screenWidth! * 0.4,
                    height: SizeConfig.screenHeight! * 0.5,
                  ),
                  CustomTextFormField(
                      hintText: "Email",
                      controller: emailController,
                      issecurse: false,
                      icon: Icons.email,
                      typefield: "email"),
                  SizedBox(
                    height: SizeConfig.screenWidth! * 0.01,
                  ),
                  CustomTextFormField(
                      hintText: "Password",
                      controller: passwordController,
                      issecurse: true,
                      icon: Icons.admin_panel_settings,
                      typefield: "password"),
                  SizedBox(
                    height: SizeConfig.screenWidth! * 0.02,
                  ),
                  CustomElevatedButton(
                      text: "Login",
                      buttonWidth: SizeConfig.screenWidth! * 0.2,
                      buttonheight: SizeConfig.screenHeight! * 0.08,
                      onpressed: () {
                        toastMessage(
                            msg: "Checking Credentials, Please wait ...");
                        allowAdminToLogin();
                      },
                      color: Colors.deepPurpleAccent,
                      textcolor: Colors.white)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void allowAdminToLogin() {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      toastMessage(msg: "Complete the form .");
    } else {
      //allow admin to login
      _authController.login(
          email: emailController.text,
          password: passwordController.text,
          context: context);
    }
  }
}
