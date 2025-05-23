import 'dart:convert';

import 'package:flutter/material.dart';

import '../../page/sign_in_and_register.dart';
import '../../model/user.dart' as u;
import '../../db/user_database.dart';

class DrawerImg extends StatefulWidget {
  const DrawerImg({super.key});

  @override
  State<DrawerImg> createState() => _DrawerImgState();
}

class _DrawerImgState extends State<DrawerImg> {
  late List<u.User> users;
  bool isLoading = false;

  Future refreshUsers() async {
    setState(() => isLoading = true);

    users = await UsersDatabase.instance.readAllUser();

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    refreshUsers();
  }

  String backImg = "";
  String img = "";
  String name = "";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SignInAndRegister(),
        ));
      },
      child: Container(
          height: 125,
          color: Colors.grey.shade900,
          width: double.infinity,
          alignment: Alignment.center,
          child: isLoading
              ? const CircularProgressIndicator()
              : users.isEmpty
                  ? const Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "EN",
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    )
                  : Builder(builder: (context) {
                      backImg = users[0].backgroundImage;
                      img = users[0].profileImage;
                      name = users[0].name;
                      return buildDrawerImg(context, backImg, img, name);
                    })),
    );
  }

  Stack buildDrawerImg(
      BuildContext context, String backImg, String img, String name) {
    return Stack(children: [
      if (backImg != "")
        Image.memory(
          base64Decode(backImg),
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
      SizedBox(
        height: 125,
        child: Container(color: Colors.grey.shade900.withOpacity(0.6)),
      ),
      gradient(Alignment.topCenter),
      gradient(Alignment.centerLeft),
      Center(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: (img == "")
                  ? const CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                      backgroundImage: AssetImage("assets/images/img.png"),
                    )
                  : CircleAvatar(
                      radius: 40.0,
                      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                      backgroundImage: MemoryImage(base64Decode(img)),
                    ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Container gradient(alignment) {
    return Container(
      height: 125,
      alignment: Alignment.bottomRight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.center,
          end: alignment,
          colors: [
            Colors.grey.shade900.withOpacity(0),
            Colors.grey.shade900.withOpacity(1),
          ],
          tileMode: TileMode.mirror,
          stops: const [0.5, 1],
        ),
      ),
    );
  }
}
