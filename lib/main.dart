import 'package:flutter/services.dart';

import 'screens/admin_panel_student_detail.dart';
import 'screens/attendance_list.dart';
import 'screens/splashscreen.dart';
import 'screens/students_report.dart';
import 'provider/data_provider.dart';
import 'screens/admin_panel_screen.dart';
import 'screens/register_screen.dart';
import 'screens/screens.dart';
import 'screens/user_panel_screen.dart';
import 'screens/view_leaves_requests.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
    return ChangeNotifierProvider(
      create: (context) => AttendanceManagementSystem(),
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.purple, primarySwatch: Colors.purple),
        debugShowCheckedModeBanner: false,
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
          viewleaverequests: (context) => const ViewLeaveRequests(),
          studentsreport: (context) => StudentsReportScreen(),
        },
      ),
    );
  }
}

// import 'package:sliding_switch/sliding_switch.dart';
