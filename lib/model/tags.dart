import 'package:flutter/material.dart';

import 'note.dart';

class Tags {
  final Map<String, Map<String, dynamic>> tags = const {
    "AC": {
      "ID": "AC",
      "name": "Action",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 18,
    },
    "AD": {
      "ID": "AD",
      "name": "Adventures",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 19,
    },
    "CO": {
      "ID": "CO",
      "name": "Comic",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 20,
    },
    "Ck": {
      "ID": "Ck",
      "name": "Cooking",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 21,
    },
    "DE": {
      "ID": "DE",
      "name": "Demons",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 22,
    },
    "DR": {
      "ID": "DR",
      "name": "Drama",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 23,
    },
    "FC": {
      "ID": "FC",
      "name": "Fiction",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 24,
    },
    "FA": {
      "ID": "FA",
      "name": "Fighting Arts",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 25,
    },
    "GA": {
      "ID": "GA",
      "name": "Gas",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 26,
    },
    "HI": {
      "ID": "HI",
      "name": "Historinc",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 27,
    },
    "HO": {
      "ID": "HO",
      "name": "Horror",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 28,
    },
    "MA": {
      "ID": "MA",
      "name": "Magic",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 29,
    },
    "ME": {
      "ID": "ME",
      "name": "Medical",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 30,
    },
    "MI": {
      "ID": "MI",
      "name": "Military",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 31,
    },
    "MO": {
      "ID": "MO",
      "name": "Monsters",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 32,
    },
    "PS": {
      "ID": "PS",
      "name": "Psychological",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 33,
    },
    "RE": {
      "ID": "RE",
      "name": "Revenge",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 34,
    },
    "RV": {
      "ID": "RV",
      "name": "Revive",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 35,
    },
    "RO": {
      "ID": "RO",
      "name": "Romantic",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 36,
    },
    "SL": {
      "ID": "SL",
      "name": "School Life",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 37,
    },
    "SF": {
      "ID": "SF",
      "name": "Science Fiction",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 38,
    },
    "SE": {
      "ID": "SE",
      "name": "Seraglio",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 39,
    },
    "SP": {
      "ID": "SP",
      "name": "Sport",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 40,
    },
    "SU": {
      "ID": "SU",
      "name": "SuperPower",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 41,
    },
    "VR": {
      "ID": "VR",
      "name": "Virtual Reality",
      "color": Color.fromARGB(255, 255, 241, 118),
      "index": 42,
    },
    "CM": {
      "ID": "CM",
      "name": "Colorful Manga",
      "color": Color.fromARGB(255, 77, 208, 225),
      "index": 43,
    },
    "MN": {
      "ID": "MN",
      "name": "Manga",
      "color": Color.fromARGB(255, 77, 208, 225),
      "index": 44,
    },
    "WT": {
      "ID": "WT",
      "name": "Web Toon",
      "color": Color.fromARGB(255, 77, 208, 225),
      "index": 45,
    },
    "CH": {
      "ID": "CH",
      "name": "Chinese",
      "color": Color.fromARGB(255, 255, 183, 77),
      "index": 46,
    },
    "JA": {
      "ID": "JA",
      "name": "Japanese",
      "color": Color.fromARGB(255, 255, 183, 77),
      "index": 47,
    },
    "KO": {
      "ID": "KO",
      "name": "Korea",
      "color": Color.fromARGB(255, 255, 183, 77),
      "index": 48,
    },
    "PO": {
      "ID": "PO",
      "name": "Portugal",
      "color": Color.fromARGB(255, 255, 183, 77),
      "index": 49,
    },
    "ED": {
      "ID": "ED",
      "name": "End",
      "color": Color.fromARGB(255, 255, 82, 82),
      "index": 50,
    },
    "ST": {
      "ID": "ST",
      "name": "Stop",
      "color": Color.fromARGB(255, 255, 82, 82),
      "index": 51,
    },
  };
  final List<String> _starsTitle = const [
    "Zero",
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six"
  ];
  final List<Map<String, String>> _webList = const [
    {"name": "Azora", "url": "azora"},
    {"name": "G Manga", "url": "gmanga"},
    {"name": "Golden Manga", "url": "golden-manga"},
    {"name": "Team X", "url": "team"},
    {"name": "Swat", "url": "swat"},
    {"name": "Ozul Scans", "url": "ozulscans"},
  ];

  List<Map<String, dynamic>> tagsFilter(List<Note> notes) =>
      <Map<String, dynamic>>[
        {
          "name": "follow me",
          "filter": notes.where((note) => note.isImportant).toList(),
          "icon": Icons.my_library_books_rounded,
          "color": Colors.grey.shade200,
          "key": false,
        },
        {
          "name": "Waiting list",
          "filter": notes.where((note) => !note.isImportant).toList(),
          "icon": Icons.my_library_add_rounded,
          "color": Colors.grey.shade200,
          "key": false,
        },
        {
          "name": "search",
          "filter": notes,
          "icon": Icons.search_rounded,
          "color": Colors.grey.shade200,
          "key": false,
        },
        for (int index = 0; index < _starsTitle.length; index++)
          {
            "name": _starsTitle[index],
            "filter": notes.where((note) => note.number == index).toList(),
            "icon": Icons.star_rounded,
            "color": Colors.pink.shade200,
            "key": false,
          },
        for (Map<String, String> value in _webList)
          {
            "name": value["name"]!,
            "filter": notes
                .where((note) => note.urlWeb
                    .toLowerCase()
                    .contains("https://${value["url"]!}"))
                .toList(),
            "icon": Icons.public_rounded,
            "color": Colors.green.shade200,
            "key": false,
          },
        {
          "name": "Web on",
          "filter": notes
              .where((note) =>
                  note.urlWeb.contains("https") &&
                  !note.urlWeb.contains("https://azora") &&
                  !note.urlWeb.contains("https://gmanga") &&
                  !note.urlWeb.contains("https://golden-manga") &&
                  !note.urlWeb.contains("https://team") &&
                  !note.urlWeb.contains("https://swat") &&
                  !note.urlWeb.contains("https://ozulscans"))
              .toList(),
          "icon": Icons.public_rounded,
          "color": Colors.green.shade200,
          "key": false,
        },
        {
          "name": "Web off",
          "filter": notes.where((note) => note.urlWeb == "").toList(),
          "icon": Icons.public_off_rounded,
          "color": Colors.green.shade200,
          "key": false,
        },
      ] +
      tags.entries
          .map((e) => {
                "name": e.value["name"],
                "filter": notes
                    .where((note) => tagsListFun(note.codeItems)
                        .any((e2) => e2["ID"] == e.value["ID"]))
                    .toList(),
                "icon": Icons.filter_list_rounded,
                "color": e.value["color"],
                "key": false,
              })
          .toList() +
      [
        {
          "name": "Ongoing",
          "filter": notes
              .where((note) => tagsListFun(note.codeItems)
                  .every((e2) => e2["ID"] != "ED" && e2["ID"] != "ST"))
              .toList(),
          "icon": Icons.filter_list_rounded,
          "color": const Color.fromARGB(255, 255, 82, 82),
          "key": false,
        }
      ];

  List<Map<String, dynamic>> tagsListFun(String tagsKey) {
    List<Map<String, dynamic>> tagsList = [];
    for (var i = 0; i < tagsKey.length; i += 2) {
      tagsList.add(tags["${tagsKey[i]}${tagsKey[i + 1]}"]!);
    }
    return tagsList;
  }

  String tagsKeyFun(List tagsList) {
    String tagsKey = "";
    for (var i = 0; i < tagsList.length; i++) {
      tagsKey += tagsList[i]["ID"];
    }
    return tagsKey;
  }
}
