// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class GradientButton2 extends StatelessWidget {
  List<Color> gradient;
  String text;
  String text2;
  void Function() ontap;
  GradientButton2(
      {required this.gradient,
      required this.text,
      required this.text2,
      required this.ontap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: (MediaQuery.of(context).size.width / 2) - 20,
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 5), blurRadius: 5)
          ],
          gradient: LinearGradient(
            colors: gradient,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text2,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.chevron_right_outlined,
              color: Colors.white,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
