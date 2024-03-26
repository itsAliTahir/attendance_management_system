import 'package:attendance_management/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';
import '../provider/data_provider.dart';
import '../provider/theme_data.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController _usernameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    var attendaceManagementSystem =
        Provider.of<AttendanceManagementSystem>(context);
    // void disposeControllers() {
    //   _usernameController.dispose();
    //   _passwordController.dispose();
    //   super.dispose();
    // }

    String? _validateUsername(String? value) {
      if (value!.isEmpty) {
        return 'Please enter your username';
      } else if (value.length < 5) {
        return 'Username should be atleast 5 letters';
      }
      return null;
    }

    String? _validatePassword(String? value) {
      if (value!.isEmpty) {
        return 'Please enter your password';
      } else if (value.length < 8) {
        return 'Password should be atleast 8 letters';
      }
      return null;
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                    if (_formKey.currentState!.validate()) {
                      String username = _usernameController.text;
                      String password = _passwordController.text;
                      bool flag = false;
                      ShowAlertDialog obj = ShowAlertDialog();
                      for (int i = 0;
                          i <
                              attendaceManagementSystem
                                  .registeredPersons.length;
                          i++) {
                        if (attendaceManagementSystem
                                .registeredPersons[i].username ==
                            username) {
                          flag = true;
                        }
                      }
                      if (flag == false) {
                        attendaceManagementSystem.registerNewUser(
                            username, password, context);
                        _usernameController.clear();
                        _passwordController.clear();
                        obj.alertDialog(context, "Account Registered", primary);
                      } else {
                        obj.alertDialog(
                            context, "Account Already Exist", Colors.redAccent);
                      }
                      print('Username: $username, Password: $password');
                    }
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                      child: Text(
                        "Register",
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
                    const Text("Already have an account?",
                        style: TextStyle(fontSize: 16)),
                    TextButton(
                      onPressed: () {
                        _usernameController.clear();
                        _passwordController.clear();
                        Navigator.of(context).pop();
                      },
                      child: Text("Login",
                          style: TextStyle(fontSize: 16, color: primary)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
