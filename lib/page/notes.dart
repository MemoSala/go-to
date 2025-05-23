import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../db/notes_database.dart';
import '../db/user_database.dart';
import '../model/note.dart';
import '../widget/notes/build_notes.dart';
import '../widget/notes/drawer.dart';
import 'add_and_edit_note.dart';
import 'note_detail.dart';
import 'notes_filter.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  int staggeredTileBuilder = 3;
  IconData staggeredIcon = Icons.auto_awesome_mosaic_rounded;
  late List<Note> notes;
  bool isLoading = true;
  bool isLoadingOpen = true;
  final int randomImage = Random.secure().nextInt(9) + 1;

  Future refreshNotes() async {
    notes = await NotesDatabase.instance.readAllNote();

    setState(() => isLoading = false);
  }

  Future openNotes() async {
    setState(() => isLoading = true);
    setState(() => isLoadingOpen = true);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => isLoading = false);
    });
    notes = await NotesDatabase.instance.readAllNote();

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() => isLoadingOpen = false);
    });
  }

  @override
  void initState() {
    super.initState();
    openNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    UsersDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoadingOpen)
        ? Scaffold(
            body: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(
                  "assets/images/($randomImage).jpg",
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
                Container(color: Colors.black.withOpacity(0.5)),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: isLoading ? 0 : 1,
                  child: Image.asset(
                    "assets/images/ic_launcher.png",
                    width: 150,
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            key: _key,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotesFilter(index: 2, notes: notes),
                    ));
                  },
                  icon: const Icon(Icons.search),
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
            ),
            drawer: (isLoading) ? null : AppDrawer(notes: notes),
            body: RefreshIndicator(
              onRefresh: () {
                return refreshNotes();
              },
              child: Center(
                child: (isLoading)
                    ? const CircularProgressIndicator()
                    : notes.isEmpty
                        ? const Text(
                            "No Notes",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )
                        : BuildNotes(
                            notes: notes,
                            staggeredTileBuilder: staggeredTileBuilder,
                            onTap: (note) async {
                              await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NoteDetail(noteId: note.id!)));
                              refreshNotes();
                            },
                          ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black45,
              elevation: 0.5,
              child: const Icon(Icons.add),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const AddAndEditNote()),
                );
                refreshNotes();
              },
            ),
          );
  }
}
