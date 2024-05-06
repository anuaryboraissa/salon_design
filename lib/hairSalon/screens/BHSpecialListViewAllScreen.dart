import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/model/BHModel.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/utils/BHColors.dart';
import 'package:flutter_hair_salon_app_main/hairSalon/utils/BHDataProvider.dart';
import 'package:flutter_hair_salon_app_main/main/utils/AppWidget.dart';
import 'BHDetailScreen.dart';
import 'package:nb_utils/nb_utils.dart';

class BHSpecialListViewAllScreen extends StatefulWidget {
  static String tag = '/SpecialListViewAllScreen';

  final String specialList;

  BHSpecialListViewAllScreen({required this.specialList});

  @override
  BHSpecialListViewAllScreenState createState() =>
      BHSpecialListViewAllScreenState();
}

class BHSpecialListViewAllScreenState
    extends State<BHSpecialListViewAllScreen> {
  late List<BHBestSpecialModel> bestSpecialList;

  @override
  void initState() {
    super.initState();
    bestSpecialList = getSpecialList();
  }

  Widget specialListViewAllWidget() {
    return Container(
      // padding: EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
        padding: const EdgeInsets.all(5),
        shrinkWrap: true,
        itemCount: bestSpecialList.length,
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
                    child: commonCacheImageWidget(
                        bestSpecialList[index].img, 110,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      bestSpecialList[index].title,
                      style: TextStyle(
                          fontSize: 16,
                          color: BHAppTextColorPrimary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(bestSpecialList[index].subTitle,
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
        title: Text(widget.specialList,
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
          child: Icon(Icons.arrow_back, color: blackColor),
        ),
      ),
      body: specialListViewAllWidget(),
    );
  }
}
