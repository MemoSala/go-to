import 'dart:math';

import 'package:flutter/material.dart';

const List<List<Color>> listColor = [
  [Colors.red, Colors.redAccent],
  [Colors.blue, Colors.blueAccent],
  [Colors.cyan, Colors.cyanAccent],
  [Colors.lime, Colors.limeAccent],
  [Colors.pink, Colors.pinkAccent],
  [Colors.teal, Colors.tealAccent],
  [Colors.green, Colors.greenAccent],
  [Colors.orange, Colors.orangeAccent],
  [Colors.purple, Colors.purpleAccent],
  [Colors.yellow, Colors.yellowAccent],
  [Colors.lightBlue, Colors.lightBlueAccent],
  [Colors.deepOrange, Colors.deepOrangeAccent],
  [Colors.deepPurple, Colors.deepPurpleAccent],
  [Colors.lightGreen, Colors.lightGreenAccent],
];

class LineageCircleWidget extends StatelessWidget {
  const LineageCircleWidget(
      {super.key, required this.lineages, this.isDark = 0});

  final List<Map<String, dynamic>> lineages;
  final int isDark;

  @override
  Widget build(BuildContext context) {
    int total = 0;
    for (var element in lineages) {
      total += element["num"] as int;
    }
    return Row(
      children: [
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 8,
          child: CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width * 1 / 2,
              MediaQuery.of(context).size.width * 1 / 2,
            ),
            painter: LineageCircle(
              lineages: lineages.map((e) => e["num"] as int).toList(),
              isDark: isDark,
              size: MediaQuery.of(context).size.width * 1 / 2,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text.rich(TextSpan(children: [
            for (int index = 0; index < lineages.length; index++)
              TextSpan(children: [
                TextSpan(
                  text: "${lineages[index]["name"]}: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: listColor[index % listColor.length][isDark],
                  ),
                ),
                TextSpan(
                  text: "${lineages[index]["num"] * 100 ~/ total}%",
                  style: TextStyle(
                    color: isDark == 0 ? Colors.white : Colors.black,
                  ),
                ),
                TextSpan(
                  text: " (${lineages[index]["num"]})\n",
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark == 0 ? Colors.white60 : Colors.black54,
                  ),
                )
              ]),
          ])),
        ),
      ],
    );
  }
}

class LineageCircle extends CustomPainter {
  LineageCircle({required this.lineages, this.isDark = 0, this.size = 100});
  final List<int> lineages;
  final int isDark;
  final double size;
  @override
  void paint(Canvas canvas, Size size) {
    int total = 0;
    for (var element in lineages) {
      total += element;
    }
    for (var index = 0; index < lineages.length; index++) {
      int lineage = 0;
      for (var i = 0; i < index; i++) {
        lineage += lineages[i];
      }
      canvas.drawArc(
        Rect.fromLTWH(0, 0, this.size, this.size),
        lineage * 2 * pi / total, // startAngle
        lineages[index] * 2 * pi / total, // sweepAngle
        true, // useCenter
        Paint()..color = listColor[index % listColor.length][isDark], //paint
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
