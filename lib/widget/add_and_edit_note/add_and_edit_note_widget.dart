// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:image_picker/image_picker.dart';

import '../../model/tags.dart';
import 'add_tag_widget.dart';
import 'add_time.dart';

class AddAndEditNoteWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final int? chapterEnd;
  final int? chapterWait;
  final String? title;
  final String? urlWeb;
  final String? description;
  final String? codeImg;
  final String? codeItems;
  final DateTime createdTimeEnd;
  final DateTime createdTimeWait;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedChapterEnd;
  final ValueChanged<String> onChangedChapterWait;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedCodeImg;
  final ValueChanged<String> onChangedCodeItems;
  final ValueChanged<String> onChangedUrlWeb;
  final ValueChanged<DateTime> onCreatedTimeEnd;
  final ValueChanged<DateTime> onCreatedTimeWait;

  const AddAndEditNoteWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.chapterEnd = 0,
    this.chapterWait = 0,
    this.title = '',
    this.urlWeb = '',
    this.description = '',
    this.codeImg = '',
    this.codeItems = '',
    required this.createdTimeEnd,
    required this.createdTimeWait,
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedChapterEnd,
    required this.onChangedChapterWait,
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedCodeImg,
    required this.onChangedCodeItems,
    required this.onChangedUrlWeb,
    required this.onCreatedTimeEnd,
    required this.onCreatedTimeWait,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tags tagsClass = Tags();
    List<Map<String, dynamic>> listItems = tagsClass.tagsListFun(codeItems!);
    List<Widget> listTagsWidget = [];
    tagsClass.tags.forEach((key, value) {
      listTagsWidget.add(
        AddTagWidget(
          value: value,
          listItems: listItems,
          onChangedCodeItems: onChangedCodeItems,
        ),
      );
    });
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: (codeImg != "")
                    ? DecorationImage(
                        image: MemoryImage(base64Decode(codeImg!)),
                        fit: BoxFit.cover,
                      )
                    : null,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        var imgpPicked =
                            await picker.getImage(source: ImageSource.gallery);

                        if (imgpPicked != null) {
                          File file = File(imgpPicked.path);
                          int size = await file.length();
                          if (size < 1500000) {
                            Uint8List imageBytes = await file.readAsBytes();
                            onChangedCodeImg(base64.encode(imageBytes));
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.add_photo_alternate_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    if (codeImg != "")
                      IconButton(
                        onPressed: () => onChangedCodeImg(""),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            buildTitle(),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              buildNumber(context, "$chapterEnd", onChangedChapterEnd),
              Text(
                "${createdTimeEnd.year} ${intl.DateFormat.MMMd().format(createdTimeEnd)} ",
                style: const TextStyle(color: Colors.white70, fontSize: 18),
              ),
              buildDataTime(
                Icons.more_time_rounded,
                () => showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => AddTime(
                    onCreated: onCreatedTimeEnd,
                    time: createdTimeEnd,
                  ),
                ),
              ),
              buildDataTime(
                Icons.access_time_rounded,
                () => onCreatedTimeEnd(DateTime.now()),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              buildNumber(context, "$chapterWait", onChangedChapterWait),
              Text(
                "${createdTimeWait.year} ${intl.DateFormat.MMMd().format(createdTimeWait)} ",
                style: const TextStyle(color: Colors.white70, fontSize: 18),
              ),
              buildDataTime(
                Icons.more_time_rounded,
                () => showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => AddTime(
                    onCreated: onCreatedTimeWait,
                    time: createdTimeWait,
                  ),
                ),
              ),
              buildDataTime(
                Icons.access_time_rounded,
                () => onCreatedTimeWait(DateTime.now()),
              ),
            ]),
            buildTitle(isTitel: false),
            buildUrlWeb(),
            Row(
              children: [
                Switch(
                  value: isImportant ?? false,
                  onChanged: onChangedImportant,
                ),
                Expanded(
                  child: Slider(
                    value: (number ?? 0).toDouble(),
                    min: 0,
                    max: 6,
                    divisions: 6,
                    onChanged: (number) => onChangedNumber(number.toInt()),
                  ),
                ),
                Text("$number", style: const TextStyle(color: Colors.white70))
              ],
            ),
            Wrap(runSpacing: 2.0, spacing: 2.0, children: listTagsWidget),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  GestureDetector buildDataTime(icon, onCreatedTime) => GestureDetector(
        onTap: onCreatedTime,
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.grey.shade700,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(icon, color: Colors.white70),
        ),
      );

  TextFormField buildTitle({bool isTitel = true}) => TextFormField(
        minLines: 1,
        maxLines: isTitel ? 1 : 100,
        initialValue: isTitel ? title : description,
        style: TextStyle(
          color: Colors.white70,
          fontWeight: isTitel ? FontWeight.bold : null,
          fontSize: isTitel ? 24 : 18,
        ),
        textDirection: isTitel ? null : TextDirection.rtl,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: isTitel ? 'Title' : 'Type something...',
          hintStyle: const TextStyle(color: Colors.white70),
        ),
        validator: (title) => isTitel
            ? title != null && title.isEmpty
                ? 'The title cannot be empty'
                : null
            : title != null && title.isEmpty
                ? 'The description cannot be empty'
                : null,
        onChanged: isTitel ? onChangedTitle : onChangedDescription,
      );

  TextFormField buildUrlWeb() => TextFormField(
        maxLines: 1,
        initialValue: urlWeb,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'UrlWeb...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        onChanged: onChangedUrlWeb,
      );

  SizedBox buildNumber(context, value, onChangedChapter) => SizedBox(
        width: MediaQuery.of(context).size.width / 2 - 50,
        child: TextFormField(
          maxLines: 1,
          initialValue: value,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white60, fontSize: 18),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: (value == 0) ? 'Number...' : "$value",
            hintStyle: const TextStyle(color: Colors.white60),
          ),
          onChanged: onChangedChapter,
        ),
      );
}
