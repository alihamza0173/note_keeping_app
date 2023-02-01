import 'package:flutter/material.dart';
import 'package:note_keeping_app/Models/note_model.dart';

class NoteCard extends StatelessWidget {
  final void Function() onTap;
  final void Function() onLongPress;
  final Note note;
  const NoteCard({super.key, required this.note, required this.onTap, required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(note.noteTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
              const Divider(),
              Text(note.note, style: const TextStyle(fontSize: 16.0),),
            ],
          ),
        ),
      ),
    );
  }
}