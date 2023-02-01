import 'package:flutter/material.dart';
import 'package:note_keeping_app/Databse/database_helper.dart';
import 'package:note_keeping_app/Models/note_model.dart';
import 'package:note_keeping_app/screens/add_note.dart';
import 'package:note_keeping_app/utils/utils.dart';
import 'package:note_keeping_app/widgets/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    void editNote(Note note) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddNote(
                    note: note,
                  )));
    }

    void deleteNote(Note note) async {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: const Text('Are you sure you want to delete this!'),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context, true);
                      String res = await DatabaseHelper.deleteNote(note);
                      showSnackBar(res, context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Yes'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('No'),
                  ),
                ],
              ));
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: RefreshIndicator(
          onRefresh: () {
            setState(() {
              DatabaseHelper.getAllNotes();
            });
            return DatabaseHelper.getAllNotes();
          },
          child: FutureBuilder<List<Note>?>(
            future: DatabaseHelper.getAllNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => NoteCard(
                      note: snapshot.data![index],
                      onTap: () => editNote(snapshot.data![index]),
                      onLongPress: () => deleteNote(snapshot.data![index]),
                    ),
                  );
                }
              }
              return const Center(
                child: Text('No Data'),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/AddNote');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
