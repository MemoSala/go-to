import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../model/note.dart';
import 'note_card.dart';

class BuildNotes extends StatelessWidget {
  const BuildNotes({
    super.key,
    required this.notes,
    required this.staggeredTileBuilder,
    required this.onTap,
  });
  final List<Note> notes;
  final int staggeredTileBuilder;
  final void Function(Note) onTap;

  @override
  Widget build(BuildContext context) => Container(
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Colors.grey.shade900.withOpacity(1),
              Colors.grey.shade900.withOpacity(0),
            ],
            stops: const [0.01, 0.04],
            tileMode: TileMode.mirror,
          ),
        ),
        child: StaggeredGridView.countBuilder(
          padding: const EdgeInsets.all(8),
          itemCount: notes.length,
          staggeredTileBuilder: (index) =>
              StaggeredTile.fit(staggeredTileBuilder),
          crossAxisCount: 6,
          itemBuilder: (context, index) {
            final note = notes[index];
            return GestureDetector(
              onTap: () => onTap(note),
              child: NoteCard(
                note: note,
                fontSize: staggeredTileBuilder == 6
                    ? 16
                    : 5 * staggeredTileBuilder.toDouble(),
              ),
            );
          },
        ),
      );
}
