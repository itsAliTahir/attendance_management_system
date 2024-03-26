// ignore_for_file: must_be_immutable

import 'package:alert_banner/exports.dart';
import 'package:flutter/material.dart';

class ShowAlertDialog {
  void alertDialog(BuildContext context, String title, Color color) {
    showAlertBanner(
      context,
      () => print("TAPPED"),
      AlertBannerChild(title, color),
      alertBannerLocation: AlertBannerLocation.top,
    );
  }
}

class AlertBannerChild extends StatelessWidget {
  String title;
  Color color;
  AlertBannerChild(this.title, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
