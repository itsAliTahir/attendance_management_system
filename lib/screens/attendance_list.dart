import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';
import '../provider/data_provider.dart';
import '../provider/theme_data.dart';

class AttendanceList extends StatelessWidget {
  const AttendanceList({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceListArgument args =
        ModalRoute.of(context)!.settings.arguments as AttendanceListArgument;
    var attendaceManagementSystem =
        Provider.of<AttendanceManagementSystem>(context);
    int dayspresent = attendaceManagementSystem.totalAttendance(args.user);
    int totaldays = attendaceManagementSystem.countTotalDays(args.user);

    Widget indicator(String text, Color color) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: color,
                border: Border.all(color: Colors.black)),
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
                    color: Colors.red,
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
                Colors.white,
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
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: attendaceManagementSystem.isPresentDateDay(
                              attendaceManagementSystem
                                  .generateDateList(args.user)[index],
                              attendaceManagementSystem
                                  .studentAttendance(args.user))
                          ? Color.fromARGB(255, 89, 255, 150)
                          : attendaceManagementSystem.isPresentDateDay(
                                  attendaceManagementSystem
                                      .generateDateList(args.user)[index],
                                  attendaceManagementSystem
                                      .studentLeaves(args.user))
                              ? Colors.lightBlueAccent
                              : Colors.white,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(attendaceManagementSystem
                        .generateDateList(args.user)[index]),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class AttendanceListArgument {
  final String user;
  AttendanceListArgument(this.user);
}