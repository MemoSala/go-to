import 'package:flutter/material.dart';

import '../../model/note.dart';
import '../../page/about_app.dart';
import '../../page/notes_filter.dart';
import '../../model/tags.dart';
import '../../page/pie_chart.dart';
import 'drawer_img.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.notes});
  final List<Note> notes;
  static late int iex;
  @override
  Widget build(BuildContext context) {
    iex = 0;
    List<Map<String, dynamic>> tagsFilter = Tags().tagsFilter(notes);

    List<Widget> tagsFilterListView = [];
    for (int index = 0; index < tagsFilter.length; index++) {
      Map<int, String> indexNameFilter = {
        3: "Stars",
        10: "Web",
        18: "Filter",
        46: "Country",
        50: "Status",
      };
      indexNameFilter.forEach(
        (key, value) => (index == key)
            ? tagsFilterListView.addAll([line(), titel(value)])
            : null,
      );
      if (tagsFilter[index]["filter"].isNotEmpty) {
        tagsFilterListView
            .add(buildListTile(context, tagsFilter: tagsFilter, index: index));
      }
    }
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: ListView(
          children: <Widget>[
                const DrawerImg(),
              ] +
              tagsFilterListView +
              [
                line(),
                titel("System"),
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PieChart(notes: notes),
                    ));
                  },
                  child: Container(
                    color: Colors.white.withOpacity(iex % 2 == 0 ? 0.04 : 0),
                    child: Row(children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Icon(
                          Icons.pie_chart_rounded,
                          color: Colors.white70,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            "Pie Chart",
                            style: TextStyle(
                              fontFamily: "ElMessiri",
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AboutApp(),
                    ));
                  },
                  child: Container(
                    color: Colors.white.withOpacity(iex % 2 == 0 ? 0.04 : 0),
                    child: Row(children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Icon(
                          Icons.info_outline_rounded,
                          color: Colors.white70,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            "About App",
                            style: TextStyle(
                              fontFamily: "ElMessiri",
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                //AboutApp
                const SizedBox(height: 10),
              ]),
    );
  }

  Padding titel(name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        name,
        style: const TextStyle(
          fontFamily: "ElMessiri",
          color: Colors.white70,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container line() {
    return Container(
      color: Colors.white70,
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    );
  }

  Widget buildListTile(
    context, {
    required List<Map<String, dynamic>> tagsFilter,
    required int index,
  }) {
    IconData icon = tagsFilter[index]["icon"];
    String title = tagsFilter[index]["name"];
    List<Note> notesFilter = tagsFilter[index]["filter"];
    double star = 0;
    iex++;
    for (var note in notesFilter) {
      star += note.number;
    }
    star = star / notesFilter.length;
    return GestureDetector(
      onTap: () async {
        tagsFilter[index]["key"] = true;
        Navigator.pop(context);
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NotesFilter(notes: notes, index: index),
        ));
      },
      child: Container(
        color: Colors.white.withOpacity(iex % 2 == 0 ? 0.04 : 0),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Icon(
              icon,
              color: Colors.white70,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: "ElMessiri",
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 23,
            width: 50,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white70),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(children: [
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  "$star",
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ),
              const Icon(
                Icons.star_rounded,
                color: Colors.white70,
                size: 15,
              ),
              const SizedBox(width: 6),
            ]),
          ),
          Container(
            margin: const EdgeInsets.only(left: 7, right: 10),
            height: 23,
            width: 23,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Text(
              "${notesFilter.length}",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
