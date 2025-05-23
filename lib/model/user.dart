const String tableUsers = 'Users';

class UserFields {
  static final List<String> values = [
    /// Add all fielbs
    id,
    name,
    idUser,
    email,
    profileImage,
    backgroundImage,
  ];
  static const String id = "_id";
  static const String name = "name";
  static const String idUser = "idUser";
  static const String email = "email";
  static const String profileImage = "profileImage";
  static const String backgroundImage = "backgroundImage";
}

class User {
  final int? id;
  final String name;
  final String idUser;
  final String email;
  final String profileImage;
  final String backgroundImage;

  User({
    this.id,
    required this.name,
    required this.idUser,
    required this.email,
    required this.profileImage,
    required this.backgroundImage,
  });

  User copy({
    int? id,
    String? name,
    String? idUser,
    String? email,
    String? profileImage,
    String? backgroundImage,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        idUser: idUser ?? this.idUser,
        email: email ?? this.email,
        profileImage: profileImage ?? this.profileImage,
        backgroundImage: backgroundImage ?? this.backgroundImage,
      );

  static User fromJson(Map<String, Object?> json) => User(
        id: json[UserFields.id] as int?,
        name: json[UserFields.name] as String,
        idUser: json[UserFields.idUser] as String,
        email: json[UserFields.email] as String,
        profileImage: json[UserFields.profileImage] as String,
        backgroundImage: json[UserFields.backgroundImage] as String,
      );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.idUser: idUser,
        UserFields.email: email,
        UserFields.profileImage: profileImage,
        UserFields.backgroundImage: backgroundImage,
      };
}
