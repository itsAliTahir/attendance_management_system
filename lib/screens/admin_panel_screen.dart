import 'dart:io';
import 'package:attendance_management/screens/screens.dart';
import 'package:attendance_management/widgets/gradient_button_2.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';
import '../provider/data_provider.dart';
import '../provider/theme_data.dart';
import '../widgets/icon_maker.dart';
import '../widgets/topbar.dart';
import 'admin_panel_student_detail.dart';

class MyAdminPanelScreen extends StatelessWidget {
  const MyAdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminPanelArguments args =
        ModalRoute.of(context)!.settings.arguments as AdminPanelArguments;
    var attendaceManagementSystem =
        Provider.of<AttendanceManagementSystem>(context);

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backGroundColor,
          appBar: AppBar(
            backgroundColor: backGroundColor,
            title: const Text(
              "Report",
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
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(args.user.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GradientButton2(
                      gradient: [
                        Color.fromARGB(255, 148, 72, 210),
                        Color.fromARGB(255, 231, 68, 221),
                      ],
                      text: "Report",
                      text2: "",
                      ontap: () {
                        Navigator.pushNamed(
                          context,
                          studentsreport,
                        );
                      }),
                  GradientButton2(
                      gradient: [
                        Color.fromARGB(255, 148, 71, 208),
                        Color.fromARGB(255, 50, 201, 254),
                      ],
                      text: "View Leaves",
                      text2:
                          "Requests: ${attendaceManagementSystem.totalLeavesRequests().length}",
                      ontap: () {
                        Navigator.pushNamed(
                          context,
                          viewleaverequests,
                        );
                      })
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Registered Students (${attendaceManagementSystem.userList.length})",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: attendaceManagementSystem.userList.length,
                  itemBuilder: (context, index) {
                    return DelayedDisplay(
                      child: Bounceable(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            adminPanelUserDetailScreen,
                            arguments: AdminPanelUserDetailArguments(
                                attendaceManagementSystem
                                    .userList[index].user.username),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            color: Colors.white,
                            surfaceTintColor: Colors.transparent,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: attendaceManagementSystem.returnProfilePic(
                                                        attendaceManagementSystem
                                                            .userList[index]
                                                            .user
                                                            .username) ==
                                                    "assets/placeholder.jpg"
                                                ? Image.asset(
                                                    "assets/placeholder.jpg")
                                                : Image.file(File(
                                                    attendaceManagementSystem
                                                        .returnProfilePic(
                                                            attendaceManagementSystem
                                                                .userList[index]
                                                                .user
                                                                .username)))),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        attendaceManagementSystem
                                            .userList[index].user.username,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Tooltip(
                                        message: "Grade",
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all()),
                                          child: Center(
                                              child: Text(
                                            attendaceManagementSystem
                                                .calculateGrade(
                                                    attendaceManagementSystem
                                                        .userList[index]
                                                        .user
                                                        .username),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconMaker(
                                          tooltip: "Presents",
                                          icon: Icons.person,
                                          color: Colors.greenAccent,
                                          text: attendaceManagementSystem
                                              .userList[index].attendance.length
                                              .toString()),
                                      IconMaker(
                                          tooltip: "Absents",
                                          icon: Icons.person_off_rounded,
                                          color: primary,
                                          text:
                                              "${attendaceManagementSystem.countTotalDays(attendaceManagementSystem.userList[index].user.username) - attendaceManagementSystem.userList[index].attendance.length - attendaceManagementSystem.userList[index].leaves.length}"),
                                      IconMaker(
                                          tooltip: "Leaves",
                                          icon: Icons.flag,
                                          color: Colors.lightBlueAccent,
                                          text: attendaceManagementSystem
                                              .userList[index].leaves.length
                                              .toString())
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminPanelArguments {
  final String user;
  AdminPanelArguments(this.user);
}
