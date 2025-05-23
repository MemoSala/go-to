// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../db/notes_database.dart';
import '../../model/note.dart';
import '../../model/user.dart' as u;
import '../../db/user_database.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
    required this.email,
    required this.name,
    required this.id,
    this.profileImage = "",
    this.backgroundImage = "",
    required this.appBar,
  });
  final String email, name, id, profileImage, backgroundImage;
  final AppBar appBar;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late List<Note> notes;

  late List<u.User> users;

  bool isLoading = true;
  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await NotesDatabase.instance.readAllNote();
    users = await UsersDatabase.instance.readAllUser();

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    double height = 160;
    return Scaffold(
      appBar: isLoading ? null : widget.appBar,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(children: [
              SizedBox(
                height: height +
                    ((users[0].backgroundImage == "") ? 10 : height / 2),
                child: Stack(alignment: Alignment.topCenter, children: [
                  if (users[0].backgroundImage != "")
                    Image.memory(
                      base64Decode(users[0].backgroundImage),
                      height: height,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  Positioned(
                    bottom: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(height),
                      child: (users[0].profileImage == "")
                          ? CircleAvatar(
                              radius: height / 2,
                              backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                              backgroundImage:
                                  const AssetImage("assets/images/img.png"),
                            )
                          : CircleAvatar(
                              radius: height / 2,
                              backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                              backgroundImage: MemoryImage(
                                  base64Decode(users[0].profileImage)),
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: height / 2 - 10,
                    right: 10,
                    child: newImage(() async {
                      var imgpPicked = await ImagePicker()
                          .getImage(source: ImageSource.gallery);
                      if (imgpPicked != null) {
                        File file = File(imgpPicked.path);
                        int size = await file.length();
                        if (size < 1500000) {
                          Uint8List imageBytes = await file.readAsBytes();
                          String image = base64.encode(imageBytes);
                          voidRegister(users[0].profileImage, image);
                        }
                      }
                    }, icon: Icons.edit_rounded),
                  ),
                  Positioned(
                    bottom: height / 2 - 10,
                    right: 38,
                    child: newImage(() {
                      if (users[0].backgroundImage != "") {
                        voidRegister(users[0].profileImage, "");
                      }
                    }, icon: Icons.delete_rounded),
                  ),
                  Positioned(
                    bottom: 0,
                    right: MediaQuery.of(context).size.width / 2 - 24,
                    child: newImage(() async {
                      var imgpPicked = await ImagePicker()
                          .getImage(source: ImageSource.gallery);
                      if (imgpPicked != null) {
                        File file = File(imgpPicked.path);
                        int size = await file.length();
                        if (size < 1500000) {
                          Uint8List imageBytes = await file.readAsBytes();
                          String image = base64.encode(imageBytes);
                          voidRegister(image, users[0].backgroundImage);
                        }
                      }
                    }, icon: Icons.edit_rounded),
                  ),
                  Positioned(
                    bottom: 0,
                    right: MediaQuery.of(context).size.width / 2 + 4,
                    child: newImage(() {
                      if (users[0].profileImage != "") {
                        voidRegister("", users[0].backgroundImage);
                      }
                    }, icon: Icons.delete_rounded),
                  ),
                ]),
              ),
              Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  height: 1.6,
                ),
              ),
              boxText(
                "Your Email: ${widget.email}\nYour ID: ${widget.id}",
              ),
              boxText(
                "Manga Watched: ${notes.length}\nChapter Watched: ${allChapterEnd()}\nThe last seen: ${theLastSeen()}",
              ),
              DisplayData(
                color: Colors.green,
                icon: Icons.cloud_upload_rounded,
                onTap: () async {
                  await refreshNotes();
                  final firestore = FirebaseFirestore.instance;
                  for (var element in notes) {
                    firestore
                        .collection("email")
                        .doc(widget.email)
                        .collection("notes")
                        .doc("${element.id}")
                        .set(
                      {
                        NoteFields.chapterEnd: element.chapterEnd,
                        NoteFields.chapterWait: element.chapterWait,
                        NoteFields.codeImg: element.codeImg,
                        NoteFields.codeItems: element.codeItems,
                        NoteFields.time: element.createdTime,
                        NoteFields.timeEnd: element.createdTimeEnd,
                        NoteFields.timeWait: element.createdTimeWait,
                        NoteFields.description: element.description,
                        NoteFields.id: element.id,
                        NoteFields.isImportant: element.isImportant,
                        NoteFields.number: element.number,
                        NoteFields.title: element.title,
                        NoteFields.urlWeb: element.urlWeb,
                      },
                    );
                  }
                },
                titel: "  Upload data to the server",
              ),
              DisplayData(
                color: Colors.red,
                icon: Icons.cloud_download_rounded,
                onTap: () async {
                  setState(() => isLoading = true);
                  final firestore = FirebaseFirestore.instance;
                  NotesDatabase.instance.deleteAll();
                  for (var i = 0;
                      i <
                          await firestore
                              .collection("email")
                              .doc(widget.email)
                              .collection("notes")
                              .get()
                              .then((value) => value.docs.length);
                      i++) {
                    Note note = await firestore
                        .collection("email")
                        .doc(widget.email)
                        .collection("notes")
                        .get()
                        .then((value) => Note(
                              id: value.docs[i]["_id"],
                              chapterEnd: value.docs[i]["chapterEnd"],
                              chapterWait: value.docs[i]["chapterWait"],
                              codeImg: value.docs[i]["codeImg"],
                              codeItems: value.docs[i]["codeItems"],
                              description: value.docs[i]["description"],
                              isImportant: value.docs[i]["isImportant"],
                              number: value.docs[i]["number"],
                              createdTime: value.docs[i]["time"].toDate(),
                              createdTimeEnd: value.docs[i]["timeEnd"].toDate(),
                              createdTimeWait:
                                  value.docs[i]["timeWait"].toDate(),
                              title: value.docs[i]["title"],
                              urlWeb: value.docs[i]["urlWeb"],
                            ));
                    await NotesDatabase.instance.cerate(note);
                  }
                  await refreshNotes();
                },
                titel: "  Import data to the server",
              ),
            ]),
    );
  }

  Container boxText(text) {
    return Container(
      alignment: AlignmentDirectional.topStart,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(right: 5, left: 5, top: 2.5, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }

  GestureDetector newImage(void Function() onTap, {required IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey.shade400),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.grey.shade400,
          size: 15,
        ),
      ),
    );
  }

  int allChapterEnd() {
    int num = 0;
    for (var element in notes) {
      num += element.chapterEnd;
    }
    return num;
  }

  String theLastSeen() {
    String data = "null";
    int num = 0;
    for (var element in notes) {
      if (num < element.createdTime.millisecondsSinceEpoch) {
        num = element.createdTime.millisecondsSinceEpoch;
        data =
            "${element.createdTimeWait.year} ${intl.DateFormat.MMMd().format(element.createdTimeWait)}";
      }
    }
    return data;
  }

  voidRegister(profileImage, backgroundImage) async {
    setState(() => isLoading = true);
    try {
      await updateUser(profileImage, backgroundImage);
      users = await UsersDatabase.instance.readAllUser();
      final firestore = FirebaseFirestore.instance;
      await firestore.collection("email").doc(widget.email).update({
        "Background Image": backgroundImage,
        "Profile Image": profileImage,
      });
      setState(() => isLoading = false);
    } catch (e) {
      null;
    }
  }

  Future updateUser(profileImage, backgroundImage) async {
    final note = users.first.copy(
      name: widget.name,
      idUser: widget.id,
      email: widget.email,
      profileImage: profileImage,
      backgroundImage: backgroundImage,
    );

    await UsersDatabase.instance.update(note);
  }
}

class DisplayData extends StatelessWidget {
  const DisplayData({
    super.key,
    required this.titel,
    required this.color,
    required this.icon,
    required this.onTap,
  });
  final String titel;
  final Color color;
  final IconData icon;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titel,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(),
        IconButton(
          onPressed: onTap,
          iconSize: 32,
          color: color,
          icon: Icon(icon),
        ),
        const SizedBox()
      ],
    );
  }
}
