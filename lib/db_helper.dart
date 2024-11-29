import 'package:notes_app/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  DbHelper._();

  static DbHelper getInstance() => DbHelper._();

  Database? myDB;

  static const String TABLE_NOTE = "notes";
  static const String NOTE_COLUMN_ID = "t_id";
  static const String NOTE_COLUMN_TITLE = "t_title";
  static const String NOTE_COLUMN_DESCRIPTION = "t_description";
  static const String NOTE_COLUMN_CREATED_AT = "t_created_at";

  Future<Database> initDB() async{
    myDB = myDB ?? await openDB();
    return myDB!;
  }

  Future<Database> openDB() async{
    var dirPath = await getApplicationDocumentsDirectory();
    var dbPath = join(dirPath.path,"notesDB.db");

    return openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute("create table $TABLE_NOTE ( $NOTE_COLUMN_ID integer primary key autoincrement, $NOTE_COLUMN_TITLE text, $NOTE_COLUMN_DESCRIPTION text,  $NOTE_COLUMN_CREATED_AT text )");
    },);
  }

  Future<bool> addNote(NoteModel noteModel) async{
    Database db = await initDB();
    int rowsEffected = await db.insert(TABLE_NOTE, noteModel.toMap());
    return rowsEffected>0;
  }

  Future<List<NoteModel>> fetchAllNote() async{
    Database db = await initDB();
    List<NoteModel> myNotes = [ ];
    List<Map<String,dynamic>> allTasks = await db.query(TABLE_NOTE);
    for(Map<String,dynamic> eachData in allTasks){
        NoteModel eachNote = NoteModel.fromMap(eachData);
        myNotes.add(eachNote);
    }
    return myNotes;
  }

  Future<bool> updateNote(NoteModel noteModel) async{
    Database db = await initDB();
    int rowsEffected = await db.update(TABLE_NOTE, {
      NOTE_COLUMN_TITLE : noteModel.title,
      NOTE_COLUMN_DESCRIPTION : noteModel.description
    }, where: "$NOTE_COLUMN_ID = ${noteModel.id}");
    return rowsEffected>0;
  }

  Future<bool> deleteNote({required int id}) async{
    Database db = await initDB();
    int rowsEffected = await db.delete(TABLE_NOTE,where: "$NOTE_COLUMN_ID = $id" );
    return rowsEffected>0;
  }
}