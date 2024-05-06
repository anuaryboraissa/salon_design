import 'dart:async';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/screens/BHWalkThroughScreen.dart';

import '../../services/sqlite/helpers/login_user.dart';
import 'BHDashedBoardScreen.dart';

class BHSplashScreen extends StatefulWidget {
  static String tag = '/BHSplashScreen';

  @override
  BHSplashScreenState createState() => BHSplashScreenState();
}

class BHSplashScreenState extends State<BHSplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    Timer(Duration(seconds: 2), () {
      // finish(context);
      // BHWalkThroughScreen().launch(context);
      LoginUserHelper().queryAll().then((value) {
        if (value.isNotEmpty) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const BHDashedBoardScreen(),
              ),
              (_) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => BHWalkThroughScreen(),
              ),
              (_) => false);
        }
      });
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset('images/hairSalon/bh_logo.svg',
            height: 250, width: 250, color: Colors.black.withOpacity(0.7)),
      ),
    );
  }
}
