import 'package:attendance_management/screens/admin_panel_student_detail.dart';
import 'package:attendance_management/screens/attendance_list.dart';
import 'package:attendance_management/screens/splashscreen.dart';
import 'package:attendance_management/widgets/login.dart';

import 'provider/data_provider.dart';
import 'screens/admin_panel_screen.dart';
import 'screens/register_screen.dart';
import 'screens/screens.dart';
import 'screens/user_panel_screen.dart';
import 'screens/view_leaves_requests.dart';
import 'widgets/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_switch_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AttendanceManagementSystem(),
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.blue, primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        // home: MyUserPanelScreen(),

        initialRoute: '/',
        routes: {
          initialScreen: (context) => const MySplashScreen(),
          loginScreen: (context) => const LoginRegisterSwitchScreen(),
          registerScreen: (context) => const RegisterScreen(),
          userPanelScreen: (context) => const MyUserPanelScreen(),
          attendanceDetailScreen: (context) => const AttendanceList(),
          adminPanelScreen: (context) => const MyAdminPanelScreen(),
          adminPanelUserDetailScreen: (context) =>
              const MyAdminPanelUserDetail(),
          viewleaverequests: (context) => const ViewLeaveRequests()
        },
      ),
    );
  }
}

// import 'package:sliding_switch/sliding_switch.dart';
