import 'package:flutter/material.dart';

import '../db/notes_database.dart';
import '../model/note.dart';
import '../widget/add_and_edit_note/add_and_edit_note_widget.dart';

class AddAndEditNote extends StatefulWidget {
  final Note? note;

  const AddAndEditNote({super.key, this.note});
  @override
  State<AddAndEditNote> createState() => _AddAndEditNoteState();
}

class _AddAndEditNoteState extends State<AddAndEditNote> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late int chapterEnd;
  late int chapterWait;
  late String title;
  late String urlWeb;
  late String description;
  late String codeImg;
  late String codeItems;
  late DateTime createdTimeEnd;
  late DateTime createdTimeWait;

  @override
  void initState() {
    super.initState();

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    chapterEnd = widget.note?.chapterEnd ?? 0;
    chapterWait = widget.note?.chapterWait ?? 0;
    title = widget.note?.title ?? '';
    urlWeb = widget.note?.urlWeb ?? '';
    description = widget.note?.description ?? '';
    codeImg = widget.note?.codeImg ?? '';
    codeItems = widget.note?.codeItems ?? '';
    createdTimeEnd = widget.note?.createdTimeEnd ?? DateTime.now();
    createdTimeWait = widget.note?.createdTimeWait ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(actions: [buildButton()]),
        body: Form(
          key: _formKey,
          child: AddAndEditNoteWidget(
            isImportant: isImportant,
            number: number,
            chapterEnd: chapterEnd,
            chapterWait: chapterWait,
            title: title,
            description: description,
            codeImg: codeImg,
            codeItems: codeItems,
            urlWeb: urlWeb,
            createdTimeEnd: createdTimeEnd,
            createdTimeWait: createdTimeWait,
            onChangedImportant: (isImportant) =>
                setState(() => this.isImportant = isImportant),
            onChangedNumber: (number) => setState(() => this.number = number),
            onChangedChapterEnd: (chapterEnd) {
              (chapterEnd == "")
                  ? setState(() => this.chapterEnd = 0)
                  : setState(() => this.chapterEnd = int.parse(chapterEnd));
            },
            onChangedChapterWait: (chapterWait) {
              (chapterWait == "")
                  ? setState(() => this.chapterWait = 0)
                  : setState(() => this.chapterWait = int.parse(chapterWait));
            },
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
            onChangedCodeImg: (codeImg) =>
                setState(() => this.codeImg = codeImg),
            onChangedCodeItems: (codeItems) =>
                setState(() => this.codeItems = codeItems),
            onChangedUrlWeb: (urlWeb) => setState(() => this.urlWeb = urlWeb),
            onCreatedTimeEnd: (createdTimeEnd) =>
                setState(() => this.createdTimeEnd = createdTimeEnd),
            onCreatedTimeWait: (createdTimeWait) =>
                setState(() => this.createdTimeWait = createdTimeWait),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      addOrUpdateNoteAsync();
      Navigator.of(context).pop();
    }
  }

  void addOrUpdateNoteAsync() async {
    final isUpdating = widget.note != null;

    if (isUpdating) {
      await updateNote();
    } else {
      await addNote();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      number: number,
      chapterEnd: chapterEnd,
      chapterWait: chapterWait,
      title: title,
      urlWeb: urlWeb,
      description: description,
      codeImg: codeImg,
      codeItems: codeItems,
      createdTimeEnd: createdTimeEnd,
      createdTimeWait: createdTimeWait,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      urlWeb: urlWeb,
      isImportant: isImportant,
      number: number,
      chapterEnd: chapterEnd,
      chapterWait: chapterWait,
      description: description,
      codeImg: codeImg,
      codeItems: codeItems,
      createdTime: DateTime.now(),
      createdTimeEnd: createdTimeEnd,
      createdTimeWait: createdTimeWait,
    );
    await NotesDatabase.instance.cerate(note);
  }
}
