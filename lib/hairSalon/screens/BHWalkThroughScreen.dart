import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/utils/BHColors.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/utils/BHConstants.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/utils/BHImages.dart';
import 'package:flutter_hair_salon_app_main/main/utils/AppWidget.dart';

import 'BHLoginScreen.dart';

class BHWalkThroughScreen extends StatefulWidget {
  static String tag = '/WalkThroughScreen';

  @override
  BHWalkThroughScreenState createState() => BHWalkThroughScreenState();
}

class BHWalkThroughScreenState extends State<BHWalkThroughScreen> {
  PageController _pageController = PageController();
  int currentPage = 0;
  static const _kDuration = const Duration(seconds: 1);
  static const _kCurve = Curves.ease;

  @override
  void initState() {
    super.initState();
    // changeStatusColor(Colors.transparent);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (i) {
              currentPage = i;
              setState(() {});
            },
            children: [
              Column(
                children: <Widget>[
                  commonCacheImageWidget(
                      BHWalkThroughImg1, context.height() * 0.7,
                      width: context.width(), fit: BoxFit.cover),
                  16.height,
                  Text(
                    BHWalkThroughTitle1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: BHAppTextColorPrimary),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(BHWalkThroughSubTitle1,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: BHAppTextColorSecondary)),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  commonCacheImageWidget(
                      BHWalkThroughImg2, context.height() * 0.7,
                      width: context.width(), fit: BoxFit.cover),
                  16.height,
                  Text(
                    BHWalkThroughTitle2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: BHAppTextColorPrimary),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(BHWalkThroughSubTitle2,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: BHAppTextColorSecondary)),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  commonCacheImageWidget(
                      BHWalkThroughImg3, context.height() * 0.7,
                      width: context.width(), fit: BoxFit.cover),
                  16.height,
                  Text(
                    BHWalkThroughTitle3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: BHAppTextColorPrimary),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(BHWalkThroughSubTitle3,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: BHAppTextColorSecondary)),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 90,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: DotsIndicator(
                dotsCount: 3,
                position: currentPage,
                decorator: DotsDecorator(
                  color: BHGreyColor.withOpacity(0.5),
                  activeColor: BHColorPrimary,
                  size: Size.square(9.0),
                  activeSize: Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text('Skip',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      // finish(context);
                      // BHLoginScreen().launch(context);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => BHLoginScreen(),
                          ),
                          (_) => false);
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text(BHBtnNext,
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      _pageController.nextPage(
                          duration: _kDuration, curve: _kCurve);
                    },
                  )
                ],
              ).visible(
                currentPage != 2,
                defaultWidget: Container(
                  margin: EdgeInsets.only(),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 270,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BHColorPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          // BHLoginScreen().launch(context);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BHLoginScreen(),
                          ));
                        },
                        child: Text(BHBtnGetStarted,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: whiteColor)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
