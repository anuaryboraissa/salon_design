import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/model/BHModel.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/utils/BHColors.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/utils/BHDataProvider.dart';
import 'package:flutter_hair_salon_app_main/main/utils/AppWidget.dart';

import 'BHDetailScreen.dart';

class BHSpecialOfferViewAllScreen extends StatefulWidget {
  static String tag = '/SpecialOfferViewAllScreen';
  final String offerData;

  const BHSpecialOfferViewAllScreen({super.key, required this.offerData});

  @override
  BHSpecialOfferViewAllScreenState createState() =>
      BHSpecialOfferViewAllScreenState();
}

class BHSpecialOfferViewAllScreenState
    extends State<BHSpecialOfferViewAllScreen> {
  late List<BHSpecialOfferModel> specialOfferList;

  @override
  void initState() {
    super.initState();
    specialOfferList = getSpecialOfferList();
  }

  Widget specialListViewAllWidget() {
    return Container(
      // padding: EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
        padding: const EdgeInsets.all(5),
        itemCount: specialOfferList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // BHDetailScreen().launch(context);
                  Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BHDetailScreen(),
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: whiteColor,
                boxShadow: [
                  BoxShadow(
                      color: BHGreyColor.withOpacity(0.3),
                      offset: Offset(0.0, 1.0),
                      blurRadius: 2.0)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.asset(specialOfferList[index].img,
                        height: 100, width: 200, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      specialOfferList[index].title,
                      style: TextStyle(
                          fontSize: 16,
                          color: BHAppTextColorPrimary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    child: Text(specialOfferList[index].subtitle,
                        style: TextStyle(
                            fontSize: 14, color: BHAppTextColorSecondary)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(widget.offerData,
            style: TextStyle(
                color: BHAppTextColorPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        leading: GestureDetector(
          onTap: () {
            finish(context);
          },
          child: const Icon(Icons.arrow_back, color: blackColor),
        ),
      ),
      body: specialListViewAllWidget(),
    );
  }
}
