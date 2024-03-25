import '../provider/data_provider.dart';
import '../widgets/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_data.dart';
import 'package:sliding_switch/sliding_switch.dart';

import '../widgets/register.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var attendaceManagementSystem =
        Provider.of<AttendanceManagementSystem>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: SizedBox(
          height: screenHeight,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 12,
                child: Container(
                  margin: const EdgeInsets.all(40),
                  child: Image.asset("assets/register.png"),
                ),
              ),
              Expanded(flex: 24, child: Register()),
            ],
          ),
        ),
      ),
    );
  }
}
