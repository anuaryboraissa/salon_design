import 'package:flutter/material.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/model/login_user.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/screens/widgets/dialogue.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/utils/BHColors.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/utils/BHConstants.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/utils/BHImages.dart';
import 'package:flutter_hair_salon_app_main/services/django_services.dart';
import 'package:flutter_hair_salon_app_main/services/sqlite/helpers/login_user.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import 'BHDashedBoardScreen.dart';
import 'BHForgotPasswordScreen.dart';
import 'BHRegistrationScreen.dart';

class BHLoginScreen extends StatefulWidget {
  static String tag = '/LoginScreen';

  @override
  BHLoginScreenState createState() => BHLoginScreenState();
}

class BHLoginScreenState extends State<BHLoginScreen> {
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  bool _showPassword = false;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();

  bool get fildsValiated =>
      emailCont.text.isNotEmpty && passwordCont.text.isNotEmpty;

  @override
  void dispose() {
    super.dispose();
    emailFocusNode.dispose();
    passWordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // changeStatusColor(BHColorPrimary);
    return SafeArea(
      child: Scaffold(
        backgroundColor: BHColorPrimary,
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(BHAppLogo,
                    color: white.withOpacity(0.8), height: 150, width: 150),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 200),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                color: whiteColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: emailCont,
                      focusNode: emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(passWordFocusNode);
                      },
                      style: TextStyle(color: blackColor),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHAppDividerColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHColorPrimary)),
                        labelText: "Email",
                        labelStyle: TextStyle(color: BHGreyColor, fontSize: 14),
                      ),
                    ),
                    TextFormField(
                      controller: passwordCont,
                      focusNode: passWordFocusNode,
                      obscureText: !_showPassword,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: blackColor),
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: BHGreyColor, fontSize: 14),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: BHColorPrimary,
                              size: 20),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHAppDividerColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHColorPrimary)),
                      ),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // BHForgotPasswordScreen().launch(context);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BHForgotPasswordScreen(),
                          ));
                        },
                        child: Text(BHTxtForgetPwd,
                            style: TextStyle(
                                color: BHAppTextColorSecondary, fontSize: 14)),
                      ),
                    ),
                    16.height,
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          // finish(context);
                          // BHDashedBoardScreen().launch(context);
                          signIn();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(12),
                          backgroundColor: BHColorPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        child: Text(BHBtnSignIn,
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    16.height,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Expanded(
                    //         child: Container(
                    //             height: 1,
                    //             color: BHAppDividerColor,
                    //             margin: EdgeInsets.only(right: 10))),
                    //     Text(BHTxtOrSignIn,
                    //         style: TextStyle(color: BHGreyColor)),
                    //     Expanded(
                    //         child: Container(
                    //             height: 1,
                    //             color: BHAppDividerColor,
                    //             margin: EdgeInsets.only(left: 10))),
                    //   ],
                    // ),
                    // 16.height,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     SvgPicture.asset(BHTwitterIcon, height: 40, width: 40),
                    //     SvgPicture.asset(BHFacebookIcon, height: 40, width: 40),
                    //     SvgPicture.asset(BHPinterestIcon,
                    //         height: 40, width: 40),
                    //   ],
                    // ),
                    // 24.height,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          // BHRegistrationScreen().launch(context);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => BHRegistrationScreen(),
                              ),
                              (_) => false);
                        },
                        child: const Text.rich(
                          TextSpan(
                            text: "You don't have an account! ",
                            style: TextStyle(color: BHAppTextColorSecondary),
                            children: <TextSpan>[
                              TextSpan(
                                  text: BHBtnSignUp,
                                  style: TextStyle(color: BHColorPrimary)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signIn() {
    if (fildsValiated) {
      appDialog(context, "Logging in...");
      DjangoServices().login((message, statusCode, data) {
        if (statusCode == 200) {
          LoginUser? user = LoginUser.fromJson(data);
          LoginUserHelper().insert(user).then((value) {
            Navigator.pop(context);
            if (value > 0) {
              Fluttertoast.showToast(msg: "Login successfully !");
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) =>
                        const BHDashedBoardScreen(),
                  ),
                  (_) => false);
            }else{
              Fluttertoast.showToast(msg: "Something went wrong while save user !",toastLength: Toast.LENGTH_LONG);
            }
          });
        } else {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
        }
      }, emailCont.text, passwordCont.text);
    } else {
      Fluttertoast.showToast(msg: "All fields are required !");
    }
  }
}
