import 'dart:io';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';
import '../provider/data_provider.dart';
import '../provider/theme_data.dart';

class MyAdminPanelUserDetail extends StatelessWidget {
  const MyAdminPanelUserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminPanelUserDetailArguments args = ModalRoute.of(context)!
        .settings
        .arguments as AdminPanelUserDetailArguments;
    var attendaceManagementSystem =
        Provider.of<AttendanceManagementSystem>(context);
    int dayspresent = attendaceManagementSystem.totalAttendance(args.user);
    int totaldays = attendaceManagementSystem.countTotalDays(args.user);

    Widget indicator(String text, Color color) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: color,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
          backgroundColor: backGroundColor,
          title: const Text(
            "Attendance Record",
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
                )),
          ),
        ),
        body: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.only(top: 10, left: 20, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: Hero(
                    tag: attendaceManagementSystem.returnProfilePic(args.user),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: attendaceManagementSystem
                                    .returnProfilePic(args.user) ==
                                "assets/placeholder.jpg"
                            ? Image.asset("assets/placeholder.jpg")
                            : Image.file(File(attendaceManagementSystem
                                .returnProfilePic(args.user)))),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    args.user,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                const Spacer(),
                Bounceable(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(right: 10, top: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Tooltip(
                      message: "Attendance",
                      child: Column(
                        children: [
                          Icon(FluentIcons.person_available_20_regular,
                              size: 40, color: primary),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "$dayspresent/$totaldays",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              indicator(
                "Unmarked",
                Color.fromARGB(255, 244, 244, 244),
              ),
              indicator(
                "Marked",
                Colors.greenAccent,
              ),
              indicator(
                "Leave",
                Colors.lightBlueAccent,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: const Divider(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  attendaceManagementSystem.generateDateList(args.user).length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                    color: attendaceManagementSystem.isPresentDateDay(
                            attendaceManagementSystem
                                .generateDateList(args.user)[index],
                            attendaceManagementSystem
                                .studentAttendance(args.user))
                        ? const Color.fromARGB(255, 89, 255, 150)
                        : attendaceManagementSystem.isPresentDateDay(
                                attendaceManagementSystem
                                    .generateDateList(args.user)[index],
                                attendaceManagementSystem
                                    .studentLeaves(args.user))
                            ? Colors.lightBlueAccent
                            : Colors.white,
                    surfaceTintColor: Colors.transparent,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            attendaceManagementSystem
                                .generateDateList(args.user)[index],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                                color: Colors.greenAccent,
                                onPressed: () {
                                  attendaceManagementSystem.toggleattendance(
                                      attendaceManagementSystem
                                          .generateDateList(args.user)[index],
                                      args.user);
                                },
                                icon: const Icon(
                                    FluentIcons.checkbox_person_20_regular)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                                color: Colors.lightBlue,
                                onPressed: () {
                                  attendaceManagementSystem.toggleleave(
                                      attendaceManagementSystem
                                          .generateDateList(args.user)[index],
                                      args.user);
                                },
                                icon: const Icon(FluentIcons.flag_20_filled)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}

class AdminPanelUserDetailArguments {
  final String user;
  AdminPanelUserDetailArguments(this.user);
}
