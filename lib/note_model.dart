import 'package:notes_app/db_helper.dart';

class NoteModel{
  int? id;
  String title;
  String description;
  String createdAt;

  NoteModel({this.id,required this.title,required this.description,required this.createdAt});

  factory NoteModel.fromMap(Map<String,dynamic> map)=> NoteModel(
      id: map[DbHelper.NOTE_COLUMN_ID],
      title: map[DbHelper.NOTE_COLUMN_TITLE],
      description: map[DbHelper.NOTE_COLUMN_DESCRIPTION],
      createdAt: map[DbHelper.NOTE_COLUMN_CREATED_AT]);

  Map<String,dynamic> toMap()=> {
      DbHelper.NOTE_COLUMN_TITLE : title,
      DbHelper.NOTE_COLUMN_DESCRIPTION : description,
      DbHelper.NOTE_COLUMN_CREATED_AT : createdAt
    };


}