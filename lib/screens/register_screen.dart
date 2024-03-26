import 'package:flutter/material.dart';
import '../provider/theme_data.dart';
import '../widgets/register.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backGroundColor,
          body: SingleChildScrollView(
            child: SizedBox(
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
                      child: Image.asset("assets/register.png"),
                    ),
                  ),
                  Expanded(flex: 24, child: Register()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
