import 'package:flutter/material.dart';

class IconMaker extends StatelessWidget {
  IconData icon;
  Color color;
  String text;
  String tooltip;
  IconMaker(
      {required this.icon,
      required this.color,
      required this.text,
      required this.tooltip,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
