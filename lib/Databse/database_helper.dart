import 'package:note_keeping_app/Models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = 'Notes.db';

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute(
          'CREATE TABLE Note(id INTEGER PRIMARY KEY, noteTitle TEXT NOT NULL, note TEXT NOT NULL )'),
          version: _version
    );
  }

  static Future<String> addNote(Note note) async{
    String res = 'Some Error';
    try{
      final db = await _getDB();
      await db.insert('Note', note.toJson());
      res = 'Note Added Successfully!';
    } catch (error){
      res = error.toString();
    }
    return res;
  }

  static Future<String> updateNote(Note note) async{
    String res = 'Some Error';
    try{
    final db = await _getDB();
    await db.update('Note', note.toJson(), where: 'id = ?', whereArgs: [note.id]);
    res = 'Note Updated Successfully!';
    } catch (error){
      res = error.toString();
    }
    return res;
  }

  static Future<String> deleteNote(Note note) async{
    String res = 'Some Error';
    try{
    final db = await _getDB();
    await db.delete('Note', where: 'id = ?', whereArgs: [note.id]);
    res = 'Note Deleted Successfully!';
    } catch (error){
      res = error.toString();
    }
    return res;
  }

  static Future<List<Note>?> getAllNotes() async{
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query('Note');
    if(maps.isEmpty){
      return null;
    }
    return List.generate(maps.length, (index) => Note.fromJson(maps[index]));
  }

//   Stream<List<Note>?> getAllNotesAsStream() {
//   return _getDB().then((db) {
//     return db.watch('Note');
//   }).asStream().map((rows) {
//     if (rows.isEmpty) {
//       return null;
//     }
//     return List.generate(rows.length, (index) => Note.fromJson(rows[index].toMap()));
//   });
// }


} 
