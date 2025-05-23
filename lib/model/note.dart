const String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fielbs
    id,
    isImportant,
    number,
    chapterEnd,
    chapterWait,
    title,
    urlWeb,
    description,
    codeImg,
    codeItems,
    time,
    timeEnd,
    timeWait,
  ];
  static const String id = "_id";
  static const String isImportant = "isImportant";
  static const String number = "number";
  static const String chapterEnd = "chapterEnd";
  static const String chapterWait = "chapterWait";
  static const String title = "title";
  static const String urlWeb = "urlWeb";
  static const String description = "description";
  static const String codeImg = "codeImg";
  static const String codeItems = "codeItems";
  static const String time = "time";
  static const String timeEnd = "timeEnd";
  static const String timeWait = "timeWait";
}

class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final int chapterEnd;
  final int chapterWait;
  final String title;
  final String urlWeb;
  final String description;
  final String codeImg;
  final String codeItems;
  final DateTime createdTime;
  final DateTime createdTimeEnd;
  final DateTime createdTimeWait;

  Note({
    this.id,
    required this.isImportant,
    required this.number,
    required this.chapterEnd,
    required this.chapterWait,
    required this.title,
    required this.urlWeb,
    required this.description,
    required this.codeImg,
    required this.codeItems,
    required this.createdTime,
    required this.createdTimeEnd,
    required this.createdTimeWait,
  });

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    int? chapterEnd,
    int? chapterWait,
    String? title,
    String? urlWeb,
    String? description,
    String? codeImg,
    String? codeItems,
    DateTime? createdTime,
    DateTime? createdTimeEnd,
    DateTime? createdTimeWait,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        chapterEnd: chapterEnd ?? this.chapterEnd,
        chapterWait: chapterWait ?? this.chapterWait,
        title: title ?? this.title,
        urlWeb: urlWeb ?? this.urlWeb,
        description: description ?? this.description,
        codeImg: codeImg ?? this.codeImg,
        codeItems: codeItems ?? this.codeItems,
        createdTime: createdTime ?? this.createdTime,
        createdTimeEnd: createdTimeEnd ?? this.createdTimeEnd,
        createdTimeWait: createdTimeWait ?? this.createdTimeWait,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        isImportant: json[NoteFields.isImportant] == 1,
        number: json[NoteFields.number] as int,
        chapterEnd: json[NoteFields.chapterEnd] as int,
        chapterWait: json[NoteFields.chapterWait] as int,
        title: json[NoteFields.title] as String,
        urlWeb: json[NoteFields.urlWeb] as String,
        description: json[NoteFields.description] as String,
        codeImg: json[NoteFields.codeImg] as String,
        codeItems: json[NoteFields.codeItems] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
        createdTimeEnd: DateTime.parse(json[NoteFields.timeEnd] as String),
        createdTimeWait: DateTime.parse(json[NoteFields.timeWait] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.number: number,
        NoteFields.chapterEnd: chapterEnd,
        NoteFields.chapterWait: chapterWait,
        NoteFields.title: title,
        NoteFields.urlWeb: urlWeb,
        NoteFields.description: description,
        NoteFields.codeImg: codeImg,
        NoteFields.codeItems: codeItems,
        NoteFields.time: createdTime.toIso8601String(),
        NoteFields.timeEnd: createdTimeEnd.toIso8601String(),
        NoteFields.timeWait: createdTimeWait.toIso8601String(),
      };
}
