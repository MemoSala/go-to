import 'package:flutter/material.dart';

import '../model/note.dart';

class Stars {
  final Note _note;
  final int direction;

  const Stars(this._note, {this.direction = 2});
  List<Widget> list() {
    List<Widget> starsList = [];
    for (double i = 0; i < _note.number; i++) {
      starsList.addAll(_iconStar(i));
    }
    if (_note.isImportant) {
      starsList.addAll(_iconStar(
        _note.number.toDouble(),
        color: const Color.fromARGB(255, 245, 142, 59),
      ));
    }
    return starsList;
  }

  List<Widget> _iconStar(double index, {Color color = Colors.amber}) => [
        Transform.translate(
          offset: Offset(direction * index * 2, 0),
          child: Icon(
            Icons.star_rounded,
            color: Colors.black,
            size: direction.abs() * 5 + 4,
          ),
        ),
        Transform.translate(
          offset: Offset(
            ((direction.isNegative) ? -2 : 2) + direction * index * 2,
            (direction.isNegative) ? -2 : 2,
          ),
          child: Icon(
            Icons.star_rounded,
            color: color,
            size: direction.abs() * 5,
          ),
        ),
      ];
}
