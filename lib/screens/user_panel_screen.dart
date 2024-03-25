import 'package:attendance_management/screens/attendance_list.dart';
import '../widgets/gradient_button.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/data_provider.dart';
import '../provider/theme_data.dart';
import '../widgets/topbar.dart';
import 'screens.dart';

class MyUserPanelScreen extends StatelessWidget {
  const MyUserPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final UserPanelArguments args =
        ModalRoute.of(context)!.settings.arguments as UserPanelArguments;
    var attendaceManagementSystem =
        Provider.of<AttendanceManagementSystem>(context);
    int dayspresent = attendaceManagementSystem.totalAttendance(args.user);
    int totaldays = attendaceManagementSystem.countTotalDays(args.user);
    Widget iconMaker({
      required String tooltip,
      required IconData? icon,
      required String text,
      required Color color,
    }) {
      return Bounceable(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Tooltip(
            message: tooltip,
            child: Column(
              children: [
                Icon(icon, size: 40, color: color),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: text == "Marked"
                        ? Colors.green
                        : text == "Leave"
                            ? const Color.fromARGB(255, 0, 149, 255)
                            : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "User Panel",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: Container(
            margin: const EdgeInsets.all(10),
            child: IconButton(
                onPressed: () {
                  ShowAlertDialog obj = ShowAlertDialog();
                  obj.alertDialog(context, "Signed Out", Colors.blueGrey);
                  Navigator.pop(context);
                },
                icon: const Icon(
                  FluentIcons.sign_out_24_regular,
                  size: 28,
                )),
          ),
          actions: [
            Container(
                margin: const EdgeInsets.all(10),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      FluentIcons.edit_12_filled,
                    ))),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red,
                    ),
                  ),
                ),
                Center(
                  child: Text(args.user.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      iconMaker(
                        tooltip: "Attendance",
                        icon: FluentIcons.person_available_20_regular,
                        text: "$dayspresent/$totaldays",
                        color: primary,
                      ),
                      // iconMaker(
                      //   tooltip: "Leave",
                      //   icon: FluentIcons.flag_20_regular,
                      //   text: "0",
                      //   color: primary,
                      // ),
                      iconMaker(
                        tooltip: "Today Status",
                        icon: FluentIcons.status_20_regular,
                        text: attendaceManagementSystem
                                    .isTodayAttendanceMarked(args.user) ==
                                true
                            ? "Marked"
                            : attendaceManagementSystem.toggleApplyLeave(
                                        args.user, 0, context) ==
                                    true
                                ? "Leave"
                                : "Unmark",
                        color: primary,
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Divider()),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Available Actions",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                GradientButton(
                    gradient: [
                      Color.fromARGB(255, 187, 4, 96),
                      Color.fromARGB(255, 250, 98, 173),
                    ],
                    text: "Mark Attendance",
                    ontap: () {
                      attendaceManagementSystem.markAttendance(
                          args.user,
                          DateFormat('ddMMMyyyy').format(DateTime.now()),
                          context);
                    }),
                GradientButton(
                    gradient: [
                      Color.fromARGB(255, 148, 71, 208),
                      Color.fromARGB(255, 50, 201, 254),
                    ],
                    text: attendaceManagementSystem.toggleApplyLeave(
                            args.user, 0, context)
                        ? "Cancel Leave"
                        : "Apply For Leave",
                    ontap: () {
                      attendaceManagementSystem.toggleApplyLeave(
                          args.user, 1, context);
                    }),
                GradientButton(
                    gradient: [
                      Color.fromARGB(255, 148, 72, 210),
                      Color.fromARGB(255, 231, 68, 221),
                    ],
                    text: "View Attendance",
                    ontap: () {
                      Navigator.pushNamed(
                        context,
                        attendanceDetailScreen,
                        arguments: AttendanceListArgument(args.user),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserPanelArguments {
  final String user;
  UserPanelArguments(this.user);
}
