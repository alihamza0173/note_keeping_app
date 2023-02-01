import 'package:flutter/material.dart';
import 'package:note_keeping_app/Databse/database_helper.dart';
import 'package:note_keeping_app/Models/note_model.dart';
import 'package:note_keeping_app/utils/utils.dart';
import 'package:note_keeping_app/widgets/text_field.dart';

class AddNote extends StatelessWidget {
  final Note? note;
  const AddNote({this.note, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController noteController = TextEditingController();

    if (note != null) {
      titleController.text = note!.noteTitle;
      noteController.text = note!.note;
    }

    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        alignment: Alignment.center,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Text(
            'What are you thinking about?',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40.0,
          ),
          MyTextField(
            controller: titleController,
          ),
          const SizedBox(
            height: 40.0,
          ),
          MyTextField(
            controller: noteController,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
          ),
          const Spacer(),
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () async {
                Note model = Note(id: note?.id, noteTitle: titleController.text, note: noteController.text,);

                if (note == null) {
                  String res = await DatabaseHelper.addNote(model);
                  showSnackBar(res, context);
                }
                 else {
                  String res = await DatabaseHelper.updateNote(model);
                  showSnackBar(res, context);
                 }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: Text(note == null ? 'Save' : 'Edit'),
            ),
          ),
        ]),
      ),
    );
  }
}
