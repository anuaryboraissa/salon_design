import 'package:flutter_hair_salon_app_main/hairSalon/screens/widgets/dialogue.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/utils/BHColors.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/utils/BHConstants.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/utils/BHImages.dart';
import 'package:flutter_hair_salon_app_main/main/utils/AppWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hair_salon_app_main/services/django_services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import 'BHLoginScreen.dart';

class BHRegistrationScreen extends StatefulWidget {
  static String tag = '/NewRegistrationScreen';

  @override
  NewRegistrationScreenState createState() => NewRegistrationScreenState();
}

class NewRegistrationScreenState extends State<BHRegistrationScreen> {
  bool _showPassword = false;
  bool _showPassword2 = false;
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController passwordCont2 = TextEditingController();
  TextEditingController fullNameCont = TextEditingController();
  TextEditingController dateOfBirthCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  int currentGroup = 0;
  List<String> types = ["Yes", "No"];

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode passwordFocusNode2 = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode dobFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    fullNameFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordFocusNode2.dispose();
    emailFocusNode.dispose();
    dobFocusNode.dispose();
    addressFocusNode.dispose();
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
              margin: const EdgeInsets.only(top: 24),
              child: Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(BHAppLogo,
                    color: white.withOpacity(0.8), height: 150, width: 150),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 200),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
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
                        FocusScope.of(context).requestFocus(dobFocusNode);
                      },
                      style: const TextStyle(color: blackColor),
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
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      focusNode: dobFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(addressFocusNode);
                      },
                      style: const TextStyle(color: blackColor),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHAppDividerColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHColorPrimary)),
                        labelText: "Phone Number",
                        labelStyle: TextStyle(color: BHGreyColor, fontSize: 14),
                      ),
                    ),
                    TextFormField(
                      controller: addressCont,
                      focusNode: addressFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                      style: const TextStyle(color: blackColor),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHAppDividerColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHColorPrimary)),
                        labelText: "Your Address",
                        suffixIcon: Icon(Icons.location_on,
                            color: BHColorPrimary, size: 18),
                        labelStyle: TextStyle(color: BHGreyColor, fontSize: 14),
                      ),
                    ),
                    16.height,
                    TextFormField(
                      controller: fullNameCont,
                      focusNode: fullNameFocusNode,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                      style: const TextStyle(color: blackColor),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHAppDividerColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: BHColorPrimary)),
                        labelText: "Full Name",
                        labelStyle: TextStyle(color: BHGreyColor, fontSize: 14),
                      ),
                    ),
                    16.height,
                    TextFormField(
                      controller: passwordCont,
                      focusNode: passwordFocusNode,
                      obscureText: !_showPassword,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: blackColor),
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle:
                            const TextStyle(color: BHGreyColor, fontSize: 14),
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
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: BHAppDividerColor)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: BHColorPrimary)),
                      ),
                    ),
                    16.height,
                    TextFormField(
                      controller: passwordCont2,
                      focusNode: passwordFocusNode2,
                      obscureText: !_showPassword2,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: blackColor),
                      decoration: InputDecoration(
                        labelText: "Password Confirm",
                        labelStyle:
                            const TextStyle(color: BHGreyColor, fontSize: 14),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showPassword2 = !_showPassword2;
                            });
                          },
                          child: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: BHColorPrimary,
                              size: 20),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: BHAppDividerColor)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: BHColorPrimary)),
                      ),
                    ),
                    16.height,
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Salon Owner ?"),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: types
                            .map(
                              (e) => Flexible(
                                child: RadioListTile(
                                  title: Text(e),
                                  value: types.indexOf(e),
                                  groupValue: currentGroup,
                                  onChanged: (value) {
                                    setState(() {
                                      currentGroup = value!;
                                    });
                                  },
                                ),
                              ),
                            )
                            .toList()),
                    16.height,
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          backgroundColor: BHColorPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: saveData,
                        child: const Text(
                          BHBtnSignUp,
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    24.height,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          finish(context);
                        },
                        child: const Text.rich(
                          TextSpan(
                            text: BHTxtAccount,
                            style: TextStyle(color: BHAppTextColorSecondary),
                            children: <TextSpan>[
                              TextSpan(
                                  text: BHBtnSignIn,
                                  style: TextStyle(color: BHColorPrimary))
                            ],
                          ),
                        ),
                      ),
                    ),
                    8.height,
                  ],
                ),
              ),
            ),
            const BackButton(color: Colors.white),
          ],
        ),
      ),
    );
  }

  void saveData() {
    if (fieldsValidated) {
    
      if (passwordCont.text == passwordCont2.text) {
          appDialog(context,"Creating account...");
        DjangoServices().register((message, statusCode, data) {
          Navigator.pop(context);
          if (statusCode == 200) {
            Fluttertoast.showToast(msg: "User registered successfully !");
            clearFields();
          } else {
             Fluttertoast.showToast(msg: message);
           
          }
        }, fullNameCont.text, emailCont.text, phoneController.text,
            addressCont.text, passwordCont.text, currentGroup == 0);
      } else {
        Fluttertoast.showToast(msg: "Password doesn't match!");
      }
    } else {
      Fluttertoast.showToast(msg: "Fields are required !");
    }
  }

  bool get fieldsValidated =>
      emailCont.text.isNotEmpty &&
      passwordCont.text.isNotEmpty &&
      passwordCont2.text.isNotEmpty &&
      phoneController.text.isNotEmpty &&
      fullNameCont.text.isNotEmpty;

  void clearFields() {
    emailCont.clear();
    phoneController.clear();
    passwordCont.clear();
    passwordCont2.clear();
    fullNameCont.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => BHLoginScreen(),
        ),
        (route) => false);
  }
}
