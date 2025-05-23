import 'package:flutter/material.dart';

import '../../model/tags.dart';

class AddTagWidget extends StatefulWidget {
  const AddTagWidget({
    super.key,
    required this.value,
    required this.listItems,
    required this.onChangedCodeItems,
  });
  final Map<String, dynamic> value;
  final List<Map<String, dynamic>> listItems;
  final ValueChanged<String> onChangedCodeItems;
  @override
  State<AddTagWidget> createState() => _AddTagWidgetState();
}

class _AddTagWidgetState extends State<AddTagWidget> {
  @override
  Widget build(BuildContext context) {
    double tagDouble =
        (widget.listItems.any((element) => element == widget.value)) ? 1 : 0;
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 250),
      tween: Tween(begin: tagDouble, end: tagDouble),
      builder: (BuildContext context, double valueDouble, Widget? child) =>
          GestureDetector(
        onTap: () {
          setState(() {
            if (tagDouble == 1) {
              tagDouble = 0;
              widget.listItems.remove(widget.value);
              widget.onChangedCodeItems(Tags().tagsKeyFun(widget.listItems));
            } else {
              tagDouble = 1;
              widget.listItems.add(widget.value);
              widget.onChangedCodeItems(Tags().tagsKeyFun(widget.listItems));
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(
                (153 + 102 * valueDouble).toInt(),
                (255 - 222 * valueDouble).toInt(),
                (255 - 105 * valueDouble).toInt(),
                255,
              ),
            ),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            widget.value["name"],
            style: TextStyle(
                color: Color.fromARGB(
                  (153 + 102 * valueDouble).toInt(),
                  (255 - 222 * valueDouble).toInt(),
                  (255 - 105 * valueDouble).toInt(),
                  255,
                ),
                shadows: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Color.fromARGB(
                      (0 + 255 * valueDouble).toInt(),
                      (255 - 222 * valueDouble).toInt(),
                      (255 - 105 * valueDouble).toInt(),
                      255,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
