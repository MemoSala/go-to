import 'package:flutter/material.dart';

import '../../model/date_time.dart';

class AddTime extends StatefulWidget {
  const AddTime({super.key, required this.time, required this.onCreated});
  final DateTime time;
  final ValueChanged<DateTime> onCreated;

  @override
  State<AddTime> createState() => _AddTimeState();
}

class _AddTimeState extends State<AddTime> {
  int valueTimeYear = 0;
  int valueTimeMonth = 0;
  int valueTimeDay = 0;
  @override
  void initState() {
    super.initState();
    valueTimeYear = widget.time.year;
    valueTimeMonth = widget.time.month;
    valueTimeDay = widget.time.day;
  }

  final List<String> days = ["SU", "MO", "TU", "WE", "TH", "FR", "SA"];

  @override
  Widget build(BuildContext context) {
    double width = 240;
    return AlertDialog(
      backgroundColor: Colors.blue.shade600,
      content: Container(
        width: width + 2.5,
        height: 175,
        padding: const EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          color: Colors.blue.shade500,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Wrap(
          spacing: 2.5,
          runSpacing: 2.5,
          children: [
            GestureDetector(
              onTap: () => setState(valueTimeMonth != 1
                  ? () => valueTimeMonth--
                  : () {
                      valueTimeMonth = 12;
                      valueTimeYear--;
                    }),
              child: Container(
                alignment: Alignment.center,
                width: (width * 2 / 7) - 2.5,
                color: Colors.white.withOpacity(0),
                child: const Text(
                  "<",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: (width * 3 / 7) - 2.5,
              child: Text(
                "$valueTimeYear / $valueTimeMonth",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            GestureDetector(
              onTap: () => setState(valueTimeMonth != 12
                  ? () => valueTimeMonth++
                  : () {
                      valueTimeMonth = 1;
                      valueTimeYear++;
                    }),
              child: Container(
                alignment: Alignment.center,
                width: (width * 2 / 7) - 2.5,
                color: Colors.white.withOpacity(0),
                child: const Text(
                  ">",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            for (String element in days) textDate(element, width, Colors.white),
            for (NumDay element
                in DateTimeDay(valueTimeYear, valueTimeMonth).time)
              textDate(
                  "${element.numper}",
                  width,
                  element.isMonth
                      ? valueTimeDay == element.numper
                          ? Colors.black
                          : Colors.white.withOpacity(0.99)
                      : Colors.white38),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            String valueTime =
                "$valueTimeYear-${valueTimeMonth < 10 ? "0" : ""}$valueTimeMonth-${valueTimeDay < 10 ? "0" : ""}$valueTimeDay";
            widget.onCreated(DateTime.parse(valueTime));
            setState(() {
              valueTime = "";
            });
            Navigator.of(context).pop();
          },
          child: const Text(
            "Add",
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  GestureDetector textDate(String element, double width, Color color) {
    return GestureDetector(
      onTap: color == Colors.white.withOpacity(0.99)
          ? () => setState(() => valueTimeDay = int.parse(element))
          : null,
      child: Container(
        width: (width / 7) - 2.5,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color == Colors.black
              ? Colors.white
              : Colors.white.withOpacity(0),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          element,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}

/*

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          maxLines: 1,
          textAlign: TextAlign.center,
          initialValue: valueTime,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white60, fontSize: 30),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Time...",
            hintStyle: TextStyle(color: Colors.white60),
          ),
          onFieldSubmitted: (value) {
            if (valueTime.length == 10) {
              widget.onCreated(DateTime.parse(valueTime));
              setState(() {
                valueTime = "";
              });
              Navigator.of(context).pop();
            }
          },
          onChanged: (value) {
            setState(() {
              valueTime = value;
            });
          },
        ),
      ),

*/
