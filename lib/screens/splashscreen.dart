import 'package:attendance_management/provider/theme_data.dart';
import 'package:attendance_management/screens/screens.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  int buildScreen = 1;
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1, milliseconds: 400)).then((value) {
      Navigator.pushNamed(
        context,
        loginScreen,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: backGroundColor),
              child: Center(
                child: Container(
                    margin: const EdgeInsets.all(50),
                    child: Image.asset("assets/splash.png")),
              ))),
    );
  }
}
