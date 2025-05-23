import 'package:flutter/material.dart';

import '../model/lineage_circle.dart';
import '../model/note.dart';
import '../model/tags.dart';

class PieChart extends StatelessWidget {
  const PieChart({super.key, required this.notes});
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tagsFilter = Tags().tagsFilter(notes);

    List<Widget> tagsFilterListView = [];
    List<Map<String, dynamic>> listMapString = [];
    for (int index = 0; index < tagsFilter.length; index++) {
      Map<int, String> indexNameFilter = {
        2: "Favorite",
        9: "Stars",
        17: "Web",
        45: "Filter",
        49: "Country",
        tagsFilter.length - 1: "Status",
      };
      String title = tagsFilter[index]["name"];
      List<Note> notesFilter = tagsFilter[index]["filter"];
      if (title != "search") {
        listMapString.add({"name": title, "num": notesFilter.length});
      }
      indexNameFilter.forEach(
        (key, value) {
          if (index == key) {
            if (value != "Filter") {
              tagsFilterListView.addAll([
                titel(value),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: LineageCircleWidget(lineages: listMapString),
                ),
              ]);
            }
            listMapString = [];
          }
        },
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Pie Chart")),
      body: ListView(children: tagsFilterListView),
    );
  }

  Padding titel(name) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: "ElMessiri",
          color: Colors.white70,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
