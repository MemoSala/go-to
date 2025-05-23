// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'dart:convert';
import 'dart:ui' as ui;

import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/note.dart';
import '../../model/tags.dart';
import '../titel_time.dart';
import '../stars.dart';

class NoteCard extends StatelessWidget {
  NoteCard({super.key, required this.note, this.fontSize = 16});
  List<Color> get _lightColors => <Color>[
        Colors.grey.shade300,
        Colors.lightBlue.shade300,
        Colors.tealAccent.shade100,
        Colors.lightGreen.shade300,
        Colors.pink.shade200,
        Colors.red.shade300,
        Colors.amber.shade300,
      ];
  final Note note;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    List listTags = Tags().tagsListFun(note.codeItems);
    final color = _lightColors[note.number];
    double padding = 5.0;
    DateTime timeNaw = DateTime.now();
    int day = timeNaw.day - note.createdTimeEnd.day;
    late int month;
    if (day < 0) {
      month = timeNaw.month - note.createdTimeEnd.month - 1;
      day = 30 + day;
    } else {
      month = timeNaw.month - note.createdTimeEnd.month;
    }
    late int year;
    if (month < 0) {
      year = timeNaw.year - note.createdTimeEnd.year - 1;
      month = 12 + month;
    } else {
      year = timeNaw.year - note.createdTimeEnd.year;
    }
    return Card(
      color: color,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: <Widget>[
                  if (Stars(note).list().isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 1, left: 1, right: 1),
                      width: double.infinity,
                      height: 23,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  if (note.codeImg != "")
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: ImageMemoryWidfet(note: note),
                      ),
                    ),
                ] +
                Stars(note, direction: fontSize ~/ 3.2).list(),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TitelTime("${note.chapterEnd}", fontSize: fontSize),
              ),
              Expanded(
                flex: 3,
                child: TitelTime(
                  "${note.createdTimeWait.year} ${intl.DateFormat.MMMd().format(note.createdTimeWait)}",
                  fontSize: fontSize,
                ),
              ),
              Expanded(
                flex: 1,
                child: TitelTime("${note.chapterWait}", fontSize: fontSize),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TitelTime(
                  "Day:$day   Month:$month   Year:$year",
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(padding),
            child: Text(
              note.title,
              style: TextStyle(
                height: 1,
                color: Colors.black,
                fontSize: fontSize * 18 / 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Text(
              note.description,
              maxLines: 3,
              textDirection: TextDirection.rtl,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: fontSize * 10 / 15,
                fontFamily: "Marhey",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(padding),
            child: Wrap(
              runSpacing: 2.0,
              spacing: 1.0,
              children: [
                for (int index = 0; index < listTags.length; index++)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: listTags[index]["color"]),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      listTags[index]["name"],
                      style: TextStyle(
                        fontSize: fontSize * 8 / 15,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageMemoryWidfet extends StatefulWidget {
  const ImageMemoryWidfet({super.key, required this.note});

  final Note note;

  @override
  State<ImageMemoryWidfet> createState() => _ImageMemoryWidfetState();
}

class _ImageMemoryWidfetState extends State<ImageMemoryWidfet> {
  Size sizeImg = const Size(1, 1);
  @override
  void initState() {
    if (widget.note.codeImg != "") {
      getImageSizeFromNetwork(base64Decode(widget.note.codeImg));
    } else {
      sizeImg = Size.zero;
    }
    super.initState();
  }

  Future getImageSizeFromNetwork(Uint8List imageUrl) async {
    Size size = Size.zero;
    try {
      final Uint8List bytes = imageUrl;
      final ui.Codec codec = await ui.instantiateImageCodec(bytes);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      size = Size(
        frameInfo.image.width.toDouble(),
        frameInfo.image.height.toDouble(),
      );
    } catch (e) {
      print(e);
    }
    setState(() {
      sizeImg = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      base64Decode(widget.note.codeImg),
      height: sizeImg.height /
          sizeImg.width *
          (MediaQuery.of(context).size.width - 35) /
          2,
    );
  }
}
