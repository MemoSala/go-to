// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:intl/intl.dart" as intl;

import '../model/note.dart';
import '../page/img.dart';
import '../page/notes_filter.dart';
import '../widget/titel_time.dart';
import 'stars.dart';

class BodyNoteDetail extends StatelessWidget {
  const BodyNoteDetail({
    super.key,
    required this.note,
    required this.listTags,
  });

  final Note note;
  final List listTags;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: <Widget>[
                  if (note.codeImg != "")
                    GestureDetector(
                      onDoubleTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Img(
                            image: note.codeImg,
                          ),
                        ));
                      },
                      child: Image.memory(
                        base64Decode(note.codeImg),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                ] +
                Stars(note, direction: -6).list(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: note.title));
                      final snackBar = SnackBar(
                        padding: const EdgeInsets.all(8),
                        content: Text(
                          'copied: ${note.title}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                        backgroundColor: (Colors.grey.shade800),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text(
                      "${note.id} \t ${note.title}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TitelTime(
                          "${note.createdTimeEnd.year} ${intl.DateFormat.MMMd().format(note.createdTimeEnd)}"),
                    ),
                    Expanded(flex: 1, child: TitelTime("${note.chapterEnd}")),
                    Expanded(
                      flex: 3,
                      child: TitelTime(
                          "${note.createdTimeWait.year} ${intl.DateFormat.MMMd().format(note.createdTimeWait)}"),
                    ),
                    Expanded(flex: 1, child: TitelTime("${note.chapterWait}")),
                  ],
                ),
                Text(
                  note.description,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontFamily: "Marhey",
                  ),
                ),
                Wrap(runSpacing: 2.0, spacing: 2.0, children: [
                  for (int index = 0; index < listTags.length; index++)
                    GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NotesFilter(
                            index: listTags[index]["index"],
                          ),
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          border: Border.all(color: listTags[index]["color"]),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          listTags[index]["name"],
                          style: TextStyle(
                            color: listTags[index]["color"],
                            shadows: [
                              BoxShadow(
                                blurRadius: 5,
                                color: listTags[index]["color"],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                ]),
                const SizedBox(height: 15),
                Text(
                  "${note.createdTime.year} ${intl.DateFormat.MMMd().format(note.createdTime)}",
                  style: const TextStyle(color: Colors.white38),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
