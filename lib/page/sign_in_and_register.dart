import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widget/sign_in_and_register/my_button.dart';
import '../widget/sign_in_and_register/profile.dart';
import '../widget/sign_in_and_register/register.dart';
import '../widget/sign_in_and_register/sign_in.dart';
import '../model/user.dart' as u;
import '../db/user_database.dart';

class SignInAndRegister extends StatefulWidget {
  const SignInAndRegister({super.key});

  @override
  State<SignInAndRegister> createState() => _SignInAndRegisterState();
}

class _SignInAndRegisterState extends State<SignInAndRegister> {
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

  String signInAndRegister = "Sign in";

  bool _saving = false;
  var _auth = FirebaseAuth.instance;
  String email = "";
  String name = "";
  String id = "";
  late String password;
  String profileImage = "";
  String backgroundImage = "";
  bool keyRegister = true, keySignIn = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height - 100;
    return _saving || isLoading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : users.isNotEmpty
            ? Builder(builder: (context) {
                backgroundImage = users[0].backgroundImage;
                profileImage = users[0].profileImage;
                name = users[0].name;
                email = users[0].email;
                id = users[0].idUser;
                return Profile(
                  email: email,
                  name: name,
                  id: id,
                  profileImage: profileImage,
                  backgroundImage: backgroundImage,
                  appBar: appBar(),
                );
              })
            : Scaffold(
                appBar: appBar(),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.center,
                      height: size,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            height: signInAndRegister == "Register" ? 300 : 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.yellow[900],
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity:
                                      signInAndRegister == "Sign in" ? 0 : 1,
                                  child: SignIn(
                                    onTap: voidSignIn,
                                    onTapEnail: addEmail,
                                    onTapPassword: addPassword,
                                  ),
                                ),
                                if (keyRegister)
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity:
                                        signInAndRegister == "Register" ? 0 : 1,
                                    child: MyButton(
                                      titel: "Sign in",
                                      onPressed: () => setState(() {
                                        signInAndRegister = "Register";
                                        keySignIn = true;
                                        Future.delayed(
                                          const Duration(milliseconds: 490),
                                          () => keyRegister = false,
                                        );
                                      }),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            height: signInAndRegister == "Sign in" ? 400 : 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue[800],
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(10),
                              ),
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity:
                                      signInAndRegister == "Register" ? 0 : 1,
                                  child: Register(
                                    profileImage: profileImage,
                                    backgroundImage: backgroundImage,
                                    onTap: voidRegister,
                                    onTapEnail: addEmail,
                                    onTapPassword: addPassword,
                                    onTapName: (value) =>
                                        setState(() => name = value),
                                    onTapProfileImage: (value) =>
                                        setState(() => profileImage = value),
                                    onTapBackgroundImage: (String value) =>
                                        setState(() => backgroundImage = value),
                                  ),
                                ),
                                if (keySignIn)
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity:
                                        signInAndRegister == "Sign in" ? 0 : 1,
                                    child: MyButton(
                                      titel: "Register",
                                      onPressed: () => setState(() {
                                        signInAndRegister = "Sign in";
                                        setState(() {
                                          keyRegister = true;
                                          Future.delayed(
                                            const Duration(milliseconds: 490),
                                            () => keySignIn = false,
                                          );
                                        });
                                      }),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
  }

  AppBar appBar() {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            _auth.signOut();
            deleteUser(users[0].id);
            refreshUsers();
          },
          icon: const Icon(Icons.exit_to_app_rounded),
        )
      ],
    );
  }

  void addPassword(String value) => setState(() => password = value);

  void addEmail(String value) => setState(() => email = value);

  void voidRegister() async {
    setState(() => _saving = true);
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      id = "$name${Random.secure().nextInt(100000)}";
      final firestore = FirebaseFirestore.instance;
      await firestore.collection("email").doc(email).set({
        "ID": id,
        "name": name,
        "email": email,
        "Profile Image": profileImage,
        "Background Image": backgroundImage,
      });
      addUser(id);
      refreshUsers();
    } catch (e) {
      null;
    }
    setState(() {
      _auth = FirebaseAuth.instance;
      _saving = false;
    });
  }

  Future addUser(id) async {
    final note = u.User(
      name: name,
      idUser: id,
      email: email,
      profileImage: profileImage,
      backgroundImage: backgroundImage,
    );

    await UsersDatabase.instance.cerate(note);
  }

  deleteUser(id) async => await UsersDatabase.instance.delete(id);

  void voidSignIn() async {
    setState(() => _saving = true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firestore = FirebaseFirestore.instance;
      Map<String, String> data =
          await firestore.collection("email").doc(email).get().then((value) => {
                "name": value["name"],
                "Profile Image": value["Profile Image"],
                "Background Image": value["Background Image"],
                "ID": value["ID"],
              });
      name = data["name"]!;
      profileImage = data["Profile Image"]!;
      backgroundImage = data["Background Image"]!;
      id = data["ID"]!;
      addUser(id);
      refreshUsers();
    } catch (e) {
      null;
    }
    setState(() {
      _saving = false;
    });
  }
}
