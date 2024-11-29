import 'package:flutter/cupertino.dart';
import 'package:notes_app/db_helper.dart';
import 'package:notes_app/note_model.dart';

class DbProvider extends ChangeNotifier{
  DbHelper dbHelper = DbHelper.getInstance();
  List<NoteModel> myNotes = [ ];

  void addNotes({required NoteModel noteModel})async{
      bool check = await dbHelper.addNote(noteModel);
      if(check){
        myNotes = await dbHelper.fetchAllNote();
        notifyListeners();
      }
  }

  void updateNotes({required NoteModel noteModel}) async{
    bool check = await dbHelper.updateNote(noteModel);
    if(check){
      myNotes = await dbHelper.fetchAllNote();
      notifyListeners();
    }
  }

  void deleteNote({required int id}) async{
      bool check = await dbHelper.deleteNote(id:id);
      if(check){
        myNotes = await dbHelper.fetchAllNote();
        notifyListeners();
      }
  }

  List<NoteModel> getAllNotes() => myNotes;

  void getInitialNotes() async{
    myNotes = await dbHelper.fetchAllNote();
    notifyListeners();
  }
}