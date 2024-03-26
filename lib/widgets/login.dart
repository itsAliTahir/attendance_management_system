// ignore_for_file: unused_local_variable

import 'package:attendance_management/screens/admin_panel_screen.dart';
import 'package:attendance_management/widgets/topbar.dart';
import '../screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';
import '../provider/data_provider.dart';
import '../provider/theme_data.dart';
import '../screens/user_panel_screen.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController _usernameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var attendaceManagementSystem =
        Provider.of<AttendanceManagementSystem>(context);

    void disposeControllers() {
      _usernameController.dispose();
      _passwordController.dispose();
      super.dispose();
    }

    String? _validateUsername(String? value) {
      if (value!.isEmpty) {
        return 'Please enter your username';
      }

      return null;
    }

    String? _validatePassword(String? value) {
      if (value!.isEmpty) {
        return 'Please enter your password';
      }
      return null;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              validator: _validateUsername,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: _validatePassword,
            ),
            const SizedBox(height: 20.0),
            Bounceable(
              onTap: () {
                late bool flag;
                flag = false;

                if (_formKey.currentState!.validate()) {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  for (int i = 0;
                      i < attendaceManagementSystem.registeredPersons.length;
                      i++) {
                    if (attendaceManagementSystem.loginModeIsAdmin == false &&
                        attendaceManagementSystem.registeredPersons[i].role ==
                            "User" &&
                        attendaceManagementSystem
                                .registeredPersons[i].username ==
                            username &&
                        attendaceManagementSystem
                                .registeredPersons[i].password ==
                            password) {
                      flag = true;
                      _usernameController.clear();
                      _passwordController.clear();
                      Navigator.pushNamed(
                        context,
                        userPanelScreen,
                        arguments: UserPanelArguments(attendaceManagementSystem
                            .registeredPersons[i].username),
                      );
                      return;
                    } else if (attendaceManagementSystem.loginModeIsAdmin ==
                            true &&
                        attendaceManagementSystem.registeredPersons[i].role ==
                            "Admin" &&
                        attendaceManagementSystem
                                .registeredPersons[i].username ==
                            username) {
                      flag = true;
                      _usernameController.clear();
                      _passwordController.clear();
                      Navigator.pushNamed(
                        context,
                        adminPanelScreen,
                        arguments: AdminPanelArguments(attendaceManagementSystem
                            .registeredPersons[i].username),
                      );
                      return;
                    }
                  }
                }
                ShowAlertDialog obj = ShowAlertDialog();
                obj.alertDialog(
                    context, "Couldn't Find Account", Colors.redAccent);
              },
              child: Container(
                height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: primary, borderRadius: BorderRadius.circular(30)),
                child: const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Don't have an account?",
                    style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                    Navigator.pushNamed(context, registerScreen);
                  },
                  child: Text("Sign Up",
                      style: TextStyle(fontSize: 16, color: primary)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
