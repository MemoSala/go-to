import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'my_button.dart';

class Register extends StatelessWidget {
  const Register({
    super.key,
    required this.profileImage,
    required this.backgroundImage,
    required this.onTap,
    required this.onTapEnail,
    required this.onTapName,
    required this.onTapPassword,
    required this.onTapProfileImage,
    required this.onTapBackgroundImage,
  });
  final String profileImage;
  final String backgroundImage;
  final void Function() onTap;
  final ValueChanged<String> onTapEnail;
  final ValueChanged<String> onTapName;
  final ValueChanged<String> onTapPassword;
  final ValueChanged<String> onTapProfileImage;
  final ValueChanged<String> onTapBackgroundImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 140,
            margin: const EdgeInsets.only(bottom: 8),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  height: 120,
                  margin: const EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  alignment: AlignmentDirectional.bottomEnd,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                    image: (backgroundImage == "")
                        ? null
                        : DecorationImage(
                            image: MemoryImage(base64Decode(backgroundImage)),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      var imgpPicked = await ImagePicker()
                          .getImage(source: ImageSource.gallery);
                      if (imgpPicked != null) {
                        File file = File(imgpPicked.path);
                        int size = await file.length();
                        if (size < 1500000) {
                          Uint8List imageBytes = await file.readAsBytes();
                          onTapBackgroundImage(base64.encode(imageBytes));
                        }
                      }
                    },
                    icon: const Icon(Icons.add_a_photo_rounded),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(70),
                    border: Border.all(),
                    image: (profileImage == "")
                        ? null
                        : DecorationImage(
                            image: MemoryImage(base64Decode(profileImage)),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      var imgpPicked = await ImagePicker()
                          .getImage(source: ImageSource.gallery);
                      if (imgpPicked != null) {
                        File file = File(imgpPicked.path);
                        int size = await file.length();
                        if (size < 1500000) {
                          Uint8List imageBytes = await file.readAsBytes();
                          onTapProfileImage(base64.encode(imageBytes));
                        }
                      }
                    },
                    iconSize: 40,
                    icon: const Icon(Icons.add_a_photo_rounded),
                  ),
                ),
              ],
            ),
          ),
          buildTextField(text: "Enter your Name", onPressed: onTapName),
          const SizedBox(height: 8),
          buildTextField(text: "Enter your Email", onPressed: onTapEnail),
          const SizedBox(height: 8),
          buildTextField(text: "Enter your Password", onPressed: onTapPassword),
          MyButton(
            titel: "register",
            onPressed: onTap,
          ),
        ],
      ),
    );
  }

  Container buildTextField(
      {required String text, required Function(String) onPressed}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        obscureText: (text == "Enter your Password") ? true : false,
        keyboardType:
            (text == "Enter your Password") ? null : TextInputType.emailAddress,
        onChanged: onPressed,
        decoration: InputDecoration(
          hintText: text,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
