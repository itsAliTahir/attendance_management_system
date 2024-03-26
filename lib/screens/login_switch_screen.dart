import '../widgets/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/data_provider.dart';
import '../provider/theme_data.dart';
import 'package:sliding_switch/sliding_switch.dart';

class LoginRegisterSwitchScreen extends StatelessWidget {
  const LoginRegisterSwitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var attendaceManagementSystem =
        Provider.of<AttendanceManagementSystem>(context);

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backGroundColor,
          body: SingleChildScrollView(
            child: Container(
              height: screenHeight - 30,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 12,
                    child: Container(
                        margin: const EdgeInsets.all(40),
                        child: Image.asset("assets/login.png")),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 30,
                      child: Center(
                        child: SlidingSwitch(
                          value: attendaceManagementSystem.loginModeIsAdmin,
                          width: 200,
                          height: 50,
                          textOff: "User",
                          textOn: "Admin",
                          colorOn: primary,
                          colorOff: primary,
                          onChanged: (bool value) {
                            attendaceManagementSystem.swtichLoginMode(
                                !attendaceManagementSystem.loginModeIsAdmin);
                            print(attendaceManagementSystem.loginModeIsAdmin);
                          },
                          onTap: () {},
                          onDoubleTap: () {},
                          onSwipe: () {},
                        ),
                      ),
                    ),
                  ),
                  Expanded(flex: 24, child: LoginScreen()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
