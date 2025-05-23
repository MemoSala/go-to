import 'package:flutter/material.dart';

import '../db/notes_database.dart';
import '../model/note.dart';
import '../model/tags.dart';
import '../widget/notes/build_notes.dart';
import 'note_detail.dart';

class NotesFilter extends StatefulWidget {
  const NotesFilter({
    super.key,
    this.notes = const [],
    required this.index,
  });

  final int index;
  final List<Note> notes;

  @override
  State<NotesFilter> createState() => _NotesFilterState();
}

class _NotesFilterState extends State<NotesFilter> {
  late List<Note> notes;
  late List<Note> notesSearch;
  late List<Map<String, dynamic>> tagsFilter;
  int staggeredTileBuilder = 3;
  IconData staggeredIcon = Icons.auto_awesome_mosaic_rounded;
  String search = "";
  bool isLoading = true;
  bool keyBottom = false;
  Tags tagsClass = Tags();

  Future refreshNotes() async {
    setState(() => isLoading = true);
    notes = widget.notes;
    if (notes.isEmpty) {
      notes = await NotesDatabase.instance.readAllNote();
    }
    tagsFilter = tagsClass.tagsFilter(notes);
    tagsFilter[widget.index]["key"] = true;
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    notesSearch = notes
        .where((e1) => e1.title.toLowerCase().contains(search.toLowerCase()))
        .toList();
    if (!isLoading) {
      for (int i = 0; i < tagsFilter.length; i++) {
        if (tagsFilter[i]["key"]) {
          notesSearch = tagsClass.tagsFilter(notesSearch)[i]["filter"];
        }
      }
    }
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0, end: keyBottom ? 20 : 0),
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    keyBottom = !keyBottom;
                  });
                },
                icon: const Icon(Icons.filter_list_rounded),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (staggeredTileBuilder == 6) {
                      staggeredTileBuilder = 3;
                      staggeredIcon = Icons.auto_awesome_mosaic_rounded;
                    } else if (staggeredTileBuilder == 3) {
                      staggeredTileBuilder = 2;
                      staggeredIcon = Icons.apps_rounded;
                    } else {
                      staggeredTileBuilder = 6;
                      staggeredIcon = Icons.view_list_rounded;
                    }
                  });
                },
                icon: Icon(staggeredIcon),
              ),
              const SizedBox(width: 10)
            ],
            bottom: (isLoading)
                ? null
                : PreferredSize(
                    preferredSize: Size.fromHeight(value),
                    child: SizedBox(
                      height: value,
                      child:
                          ListView(scrollDirection: Axis.horizontal, children: [
                        for (int index = 0; index < tagsFilter.length; index++)
                          buildListWrap(
                            text: tagsFilter[index]["name"],
                            color: tagsFilter[index]["color"],
                            key: tagsFilter[index]["key"],
                            index: index,
                          ),
                      ]),
                    ),
                  ),
            title: TextFormField(
              maxLines: 1,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "search...",
                hintStyle: TextStyle(color: Colors.white60),
              ),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ),
          body: child,
        );
      },
      child: Center(
        child: (isLoading)
            ? const CircularProgressIndicator()
            : BuildNotes(
                notes: notesSearch,
                staggeredTileBuilder: staggeredTileBuilder,
                onTap: (note) async {
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NoteDetail(noteId: note.id!),
                  ));
                  refreshNotes();
                },
              ),
      ),
    );
  }

  GestureDetector buildListWrap({
    required String text,
    required Color color,
    required bool key,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tagsFilter[index]["key"] = !tagsFilter[index]["key"];
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        margin: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          color: key ? color : null,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: key ? Colors.black : color,
          ),
        ),
      ),
    );
  }
}
