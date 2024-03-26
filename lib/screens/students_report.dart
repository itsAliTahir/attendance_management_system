import 'dart:io';
import 'package:attendance_management/widgets/icon_maker.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/data_provider.dart';
import '../provider/theme_data.dart';

class StudentsReportScreen extends StatefulWidget {
  StudentsReportScreen({super.key});

  @override
  State<StudentsReportScreen> createState() => _StudentsReportScreenState();
}

class _StudentsReportScreenState extends State<StudentsReportScreen> {
  DateTime fromDate = DateTime(2024);
  DateTime toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var attendaceManagementSystem =
        Provider.of<AttendanceManagementSystem>(context);
    void datePicker(BuildContext context, int index) {
      showDatePicker(
        context: context,
        initialDate: index == 0 ? fromDate : toDate,
        firstDate: DateTime(1800),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget? child) {
          return myTheme(child);
        },
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        if (index == 0) {
          if (pickedDate.isAfter(toDate)) {
            fromDate = toDate;
          } else {
            fromDate = pickedDate;
          }
        } else if (index == 1) {
          if (pickedDate.isBefore(fromDate)) {
            toDate = fromDate;
          } else {
            toDate = pickedDate;
          }
        }
        setState(() {});
      });
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: const Text(
          "Students Report",
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Bounceable(
                onTap: () {
                  datePicker(context, 0);
                },
                child: DateContainer(
                  label: 'From',
                  date: fromDate,
                ),
              ),
              Bounceable(
                onTap: () {
                  datePicker(context, 1);
                },
                child: DateContainer(
                  label: 'To',
                  date: toDate,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: const Divider(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: attendaceManagementSystem.userList.length,
              itemBuilder: (context, index) {
                return DelayedDisplay(
                  child: Bounceable(
                    onTap: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   adminPanelUserDetailScreen,
                      //   arguments: AdminPanelUserDetailArguments(
                      //       attendaceManagementSystem
                      //           .userList[index].user.username),
                      // );
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
          )
        ],
      ),
    ));
  }
}

class DateContainer extends StatelessWidget {
  final String label;
  final DateTime date;

  const DateContainer({
    Key? key,
    required this.label,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // padding: const EdgeInsets.all(8.0),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(8.0),
      //   border: Border.all(color: Colors.grey),
      // ),
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('ddMMMyyyy').format(date),
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
