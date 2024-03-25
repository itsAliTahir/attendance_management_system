import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class GradientButton extends StatelessWidget {
  List<Color> gradient;
  String text;
  void Function() ontap;
  GradientButton(
      {required this.gradient,
      required this.text,
      required this.ontap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
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
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
