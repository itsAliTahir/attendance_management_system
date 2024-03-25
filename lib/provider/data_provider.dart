import 'package:attendance_management/provider/theme_data.dart';
import '../model/person_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/user_model.dart';
import '../widgets/topbar.dart';

class AttendanceManagementSystem extends ChangeNotifier {
  // a dummy for keeping registered users/admins record
  final List<Person> _registeredPersons = [
    Person(username: "User1", password: "12345678", role: "User"),
    Person(username: "User2", password: "12345678", role: "User"),
    Person(username: "Admin", password: "adminadmin", role: "Admin"),
  ];

  final List<User> _usersList = [];

  bool _loginModeIsAdmin = false;
  get loginModeIsAdmin => _loginModeIsAdmin;
  get registeredPersons => _registeredPersons;
  get userList => _usersList;

  void swtichLoginMode(bool mode) {
    _loginModeIsAdmin = mode;
    notifyListeners();
  }

  void registerNewUser(String username, String password, BuildContext context) {
    _registeredPersons
        .add(Person(username: username, password: password, role: "User"));
    _usersList.add(User(
        appliedLeave: false,
        user: Person(username: username, password: password, role: "User"),
        joiningDate: DateFormat('ddMMMyyyy').format(DateTime.now()),
        attendance: [],
        leaves: []));
    Navigator.pop(context);
  }

  void markAttendance(String user, String attendance, BuildContext context) {
    ShowAlertDialog obj = ShowAlertDialog();
    for (int i = 0; i < _usersList.length; i++) {
      if (_usersList[i].user.username == user) {
        for (int j = 0; j < _usersList[i].attendance.length; j++) {
          if (_usersList[i].attendance[j] == attendance) {
            obj.alertDialog(
                context, "Attendance is Already Marked", Colors.redAccent);
            return;
          }
        }
        if (_usersList[i].leaves.contains(attendance)) {
          _usersList[i].leaves.remove(attendance);
        }
        _usersList[i].attendance.add(attendance);
        obj.alertDialog(context, "Attendance Marked", primary);
      }
    }
    notifyListeners();
  }

  bool isTodayAttendanceMarked(String user) {
    for (int i = 0; i < _usersList.length; i++) {
      if (_usersList[i].user.username == user) {
        if (_usersList[i]
            .attendance
            .contains(DateFormat('ddMMMyyyy').format(DateTime.now())))
          return true;
      }
    }
    return false;
  }

  int totalAttendance(String user) {
    for (int i = 0; i < _usersList.length; i++) {
      if (_usersList[i].user.username == user) {
        var tempSet = _usersList[i].attendance.toSet();
        return tempSet.length;
      }
    }
    return 0;
  }

  int countTotalDays(String user) {
    // Parse input dates into DateTime objects
    for (int i = 0; i < _usersList.length; i++) {
      if (_usersList[i].user.username == user) {
        String date1String = (DateFormat('ddMMMyyyy').format(DateTime.now())),
            date2String = _usersList[i].joiningDate;
        DateFormat format = DateFormat('ddMMMyyyy');
        DateTime date1 = format.parse(date1String);
        DateTime date2 = format.parse(date2String);

        // Calculate difference in days
        Duration difference = date2.difference(date1);

        // Return the absolute value of the difference as count of days
        return difference.inDays.abs() + 1;
      }
    }
    return 0;
  }

  bool toggleApplyLeave(String user, int doAction, BuildContext context) {
    for (int i = 0; i < _usersList.length; i++) {
      if (_usersList[i].user.username == user) {
        if (doAction == 1) {
          ShowAlertDialog obj = ShowAlertDialog();
          if (isTodayAttendanceMarked(user) == true) {
            obj.alertDialog(
                context, "Attendance Already Marked", Colors.blueGrey);
            return false;
          }
          _usersList[i].appliedLeave = !_usersList[i].appliedLeave;

          if (_usersList[i].appliedLeave == true) {
            obj.alertDialog(
                context, "Applied For Leave", Colors.lightBlueAccent);
          } else {
            obj.alertDialog(
                context, "Cancelled Leave Application", Colors.blueGrey);
          }
          notifyListeners();
        }

        return _usersList[i].appliedLeave;
      }
    }
    return false;
  }

  List<String> studentAttendance(String user) {
    for (int i = 0; i < _usersList.length; i++) {
      if (user == _usersList[i].user.username) {
        return _usersList[i].attendance;
      }
    }
    return [];
  }

  List<String> studentLeaves(String user) {
    for (int i = 0; i < _usersList.length; i++) {
      if (user == _usersList[i].user.username) {
        return _usersList[i].leaves;
      }
    }
    return [];
  }

  List<String> generateDateList(String user) {
    List<String> dateList = [];
    String startDate = DateFormat('ddMMMyyyy').format(DateTime.now());
    for (int i = 0; i < _usersList.length; i++) {
      if (user == _usersList[i].user.username) {
        startDate = _usersList[i].joiningDate;
      }
    }
    String endDate = DateFormat('ddMMMyyyy').format(DateTime.now());
    DateFormat dateFormat = DateFormat("ddMMMyyyy");
    DateTime start = dateFormat.parse(startDate);
    DateTime end = dateFormat.parse(endDate);

    DateFormat outputFormat = DateFormat("ddMMMyyyy");
    for (DateTime date = start;
        date.isBefore(end.add(Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
      String formattedDate = outputFormat.format(date);
      dateList.add(formattedDate);
    }

    return dateList;
  }

  bool isPresentDateDay(String argument, List<String> stringList) {
    return stringList.contains(argument);
  }

  void toggleattendance(String targetAttendance, String user) {
    for (int i = 0; i < _usersList.length; i++) {
      if (user == _usersList[i].user.username) {
        if (_usersList[i].leaves.contains(targetAttendance)) {
          _usersList[i].leaves.remove(targetAttendance);
        }
        if (_usersList[i].attendance.contains(targetAttendance)) {
          _usersList[i].attendance.remove(targetAttendance);
        } else {
          _usersList[i].attendance.add(targetAttendance);
        }
      }
      _usersList[i].appliedLeave = false;
    }

    notifyListeners();
  }

  void toggleleave(String targetAttendance, String user) {
    for (int i = 0; i < _usersList.length; i++) {
      if (user == _usersList[i].user.username) {
        if (_usersList[i].attendance.contains(targetAttendance)) {
          _usersList[i].appliedLeave = false;
          return;
        }
        if (_usersList[i].leaves.contains(targetAttendance)) {
          _usersList[i].leaves.remove(targetAttendance);
        } else {
          _usersList[i].leaves.add(targetAttendance);
        }
      }
      _usersList[i].appliedLeave = false;
    }
    notifyListeners();
  }

  List<User> totalLeavesRequests() {
    List<User> leaveRequests = [];
    for (int i = 0; i < _usersList.length; i++) {
      if (_usersList[i].appliedLeave) {
        leaveRequests.add(_usersList[i]);
      }
    }
    return leaveRequests.toSet().toList();
  }

  String calculateGrade(String user) {
    for (int i = 0; i < _usersList.length; i++) {
      if (user == _usersList[i].user.username) {
        int attendance = _usersList[i].attendance.length;
        if (attendance >= 26) {
          return 'A';
        } else if (attendance >= 20) {
          return 'B';
        } else if (attendance >= 15) {
          return 'C';
        } else if (attendance >= 10) {
          return 'D';
        } else {
          return 'F';
        }
      }
    }
    return 'F';
  }

  void acceptRejectRequest(String user, String day, int action) {
    for (int i = 0; i < _usersList.length; i++) {
      if (user == _usersList[i].user.username) {
        if (action == 1) {
          if (_usersList[i].appliedLeave) {
            _usersList[i].appliedLeave = false;
            _usersList[i].leaves.add(day);
          }
        } else if (action == 0) {
          _usersList[i].appliedLeave = false;
        }
      }
    }
    notifyListeners();
  }
}
