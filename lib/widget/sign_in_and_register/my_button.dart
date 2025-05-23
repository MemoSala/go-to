import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.titel, required this.onPressed});
  final String titel;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        elevation: 0,
        color: Colors.black.withOpacity(0),
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200,
          child: Text(
            titel,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
