import 'dart:async';
import 'package:flutter/material.dart';
import 'package:superstore_app/custom_widgets/app_profile_widget.dart';

import 'package:superstore_app/utils/functions/functions.dart';
import 'package:superstore_app/views/splash/splash_screen.dart';

class MainSplashScreen extends StatefulWidget {
  static const routeName = '/main_splash';
  const MainSplashScreen({Key? key}) : super(key: key);

  @override
  _MainSplashScreenState createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () => navigateWithPushNamed(context, SplashScreen.routeName, ""),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppProfileWidget(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
      ),
    );
  }
}
