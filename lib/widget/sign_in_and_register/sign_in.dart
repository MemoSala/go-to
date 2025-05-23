
import 'package:flutter/material.dart';

import 'my_button.dart';

class SignIn extends StatelessWidget {
  const SignIn({
    super.key,
    required this.onTap,
    required this.onTapEnail,
    required this.onTapPassword,
  });
  final void Function() onTap;
  final ValueChanged<String> onTapEnail;
  final ValueChanged<String> onTapPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        buildTextField(
          text: "Enter your Email",
          onPressed: onTapEnail,
        ),
        const SizedBox(height: 8),
        buildTextField(text: "Enter your Password", onPressed: onTapPassword),
        MyButton(
          titel: "Sign in",
          onPressed: onTap,
        ),
      ]),
    );
  }

  Container buildTextField(
      {required String text, required Function(String) onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
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
