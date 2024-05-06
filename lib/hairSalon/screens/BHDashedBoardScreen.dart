import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import'package:flutter_hair_salon_app_main/hairSalon/utils/BHColors.dart';
import'package:flutter_hair_salon_app_main/hairSalon/utils/BHConstants.dart';

import 'BHAppointmentScreen.dart';
import 'BHDiscoverScreen.dart';
import 'BHMessagesScreen.dart';
import 'BHNotifyScreen.dart';
import 'BHProfileScreen.dart';

class BHDashedBoardScreen extends StatefulWidget {
  static String tag = '/DashedBoardScreen';

  const BHDashedBoardScreen({super.key, });
  @override
  BHDashedBoardScreenState createState() => BHDashedBoardScreenState();
}

class BHDashedBoardScreenState extends State<BHDashedBoardScreen> {

  int _selectedIndex = 0;
 final _pages = <Widget>[
    BHDiscoverScreen(),
    BHNotifyScreen(),
    BHAppointmentScreen(),
    BHMessagesScreen(),
    BHProfileScreen(),
  ];

  Widget _bottomTab() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(color: BHColorPrimary),
      selectedItemColor: BHColorPrimary,
      unselectedLabelStyle: TextStyle(color: BHGreyColor),
      unselectedItemColor: BHGreyColor,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label:BHBottomNavDiscover),
        BottomNavigationBarItem(icon: Icon(Icons.business), label: BHBottomNavNotify),
        BottomNavigationBarItem(icon: Icon(Icons.date_range), label: BHBottomNavAppointment),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: BHBottomNavMessages),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: BHBottomNavProfile),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // changeStatusColor(Colors.white);

    return Scaffold(
      bottomNavigationBar: _bottomTab(),
      body: SafeArea(child: Center(child: _pages.elementAt(_selectedIndex))),
    );
  }
}
