import 'package:flutter/material.dart';

class TitelTime extends StatelessWidget {
  const TitelTime(this.title, {super.key, this.fontSize = 16.0});
  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            color: Colors.white24, borderRadius: BorderRadius.circular(4)),
        child: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: fontSize),
        ),
      );
}
