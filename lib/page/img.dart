import 'dart:convert';

import 'package:flutter/material.dart';

class Img extends StatelessWidget {
  const Img({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: InteractiveViewer(
        clipBehavior: Clip.none,
        child: Image.memory(
          base64Decode(image),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
