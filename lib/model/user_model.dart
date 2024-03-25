import 'person_model.dart';

class User {
  late Person user;
  late String joiningDate;
  late bool appliedLeave;
  late List<String> attendance;
  late List<String> leaves;
  String profilePic = "assets/placeholder.jpg";
  User(
      {required this.user,
      required this.joiningDate,
      required this.appliedLeave,
      required this.attendance,
      required this.leaves,
      required this.profilePic});
}
