import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'hairSalon/screens/BHSplashScreen.dart';
import 'main/utils/AppConstant.dart';
import 'main/utils/AppTheme.dart';
import 'services/sqlite/helpers/initializer.dart';

// AppStore appStore = AppStore();

void main() async {
  //region Entry Point
  WidgetsFlutterBinding.ensureInitialized();
 DBInitializer.inializeTables();
  // appStore.toggleDarkMode(value: await getBool(isDarkModeOnPref));

  runApp(MyApp());
  //endregion
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '$mainAppName${!isMobile ? ' ${platformName()}' : ''}',
      home:  BHSplashScreen(),
      theme:  AppThemeData.lightTheme
          // : AppThemeData.darkTheme,
    );
  }
}
