import 'dart:io';

import 'package:attendance_management/provider/theme_data.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/data_provider.dart';
import '../widgets/topbar.dart';

class ViewLeaveRequests extends StatelessWidget {
  const ViewLeaveRequests({super.key});

  @override
  Widget build(BuildContext context) {
    var attendaceManagementSystem =
        Provider.of<AttendanceManagementSystem>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
          backgroundColor: backGroundColor,
          title: const Text(
            "Leave Requests",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: Container(
            margin: const EdgeInsets.all(10),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  FluentIcons.arrow_left_28_filled,
                  size: 28,
                )),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Leave Requests (${attendaceManagementSystem.totalLeavesRequests().length})",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Divider(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount:
                    attendaceManagementSystem.totalLeavesRequests().length,
                itemBuilder: (context, index) {
                  return DelayedDisplay(
                    child: Bounceable(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        child: Card(
                          color: Colors.white,
                          surfaceTintColor: Colors.transparent,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: attendaceManagementSystem
                                                  .returnProfilePic(
                                                      attendaceManagementSystem
                                                          .totalLeavesRequests()[
                                                              index]
                                                          .user
                                                          .username) ==
                                              "assets/placeholder.jpg"
                                          ? Image.asset(
                                              "assets/placeholder.jpg")
                                          : Image.file(File(
                                              attendaceManagementSystem
                                                  .returnProfilePic(
                                                      attendaceManagementSystem
                                                          .totalLeavesRequests()[
                                                              index]
                                                          .user
                                                          .username)))),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  attendaceManagementSystem
                                      .totalLeavesRequests()[index]
                                      .user
                                      .username,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      attendaceManagementSystem
                                          .acceptRejectRequest(
                                              attendaceManagementSystem
                                                  .totalLeavesRequests()[index]
                                                  .user
                                                  .username,
                                              DateFormat('ddMMMyyyy')
                                                  .format(DateTime.now()),
                                              1);
                                      ShowAlertDialog obj = ShowAlertDialog();
                                      obj.alertDialog(
                                          context,
                                          "Request Approved",
                                          Colors.lightBlueAccent);
                                    },
                                    icon: Icon(Icons.check)),
                                SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                    onPressed: () {
                                      ShowAlertDialog obj = ShowAlertDialog();
                                      obj.alertDialog(context,
                                          "Request Rejected", Colors.blueGrey);
                                      attendaceManagementSystem
                                          .acceptRejectRequest(
                                              attendaceManagementSystem
                                                  .totalLeavesRequests()[index]
                                                  .user
                                                  .username,
                                              DateFormat('ddMMMyyyy')
                                                  .format(DateTime.now()),
                                              0);
                                    },
                                    icon: Icon(FluentIcons.delete_12_filled)),
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
    );
  }
}
