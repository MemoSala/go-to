import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../db/notes_database.dart';
import '../model/note.dart';
import '../model/tags.dart';
import '../widget/body_note_detail.dart';
import 'add_and_edit_note.dart';
import 'new_wep.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail({super.key, required this.noteId});
  final int noteId;

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    note = await NotesDatabase.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    List listTags = isLoading ? [] : Tags().tagsListFun(note.codeItems);
    return isLoading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(),
            extendBodyBehindAppBar: note.codeImg != "",
            floatingActionButton: SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              backgroundColor: Colors.black45,
              overlayOpacity: 0,
              children: [
                SpeedDialChild(
                  backgroundColor: Colors.black45,
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onTap: () => editButton(),
                ),
                SpeedDialChild(
                  backgroundColor: Colors.black45,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onTap: () => deleteButton(),
                ),
                if (note.urlWeb != 'null' && note.urlWeb != "")
                  SpeedDialChild(
                    backgroundColor: Colors.black45,
                    child: const Icon(
                      Icons.web,
                      color: Colors.white,
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            NewWeb(web: note.urlWeb),
                      ),
                    ),
                  ),
              ],
            ),
            body: BodyNoteDetail(note: note, listTags: listTags),
          );
  }

  editButton() async {
    if (isLoading) return;

    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddAndEditNote(note: note),
    ));

    refreshNote();
  }

  deleteButton() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          title: const Text(
            'Delete Note',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure to delete the note?',
            style: TextStyle(color: Colors.white70),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                deleteButtonAsync();
                Navigator.of(context).pop();
              },
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
      },
    );
  }

  deleteButtonAsync() async =>
      await NotesDatabase.instance.delete(widget.noteId);
}
