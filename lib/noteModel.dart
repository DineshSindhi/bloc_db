import 'package:bloc_db/db.dart';

class NoteModel{
  String title;
  String desc;
  String createAt;
  int id;
  NoteModel({required this.title,required this.desc,required this.createAt,this.id=0});

  factory NoteModel.fromMap(Map<String,dynamic>map){
    return NoteModel(
      id: map[AppData.TABLE_KEY_ID],
        title: map[AppData.TABLE_KEY_TITLE],
        desc: map[AppData.TABLE_KEY_DESC],
        createAt: map[AppData.TABLE_KEY_TIME]);
  }

  Map<String,dynamic>toMap(){
    return {
      AppData.TABLE_KEY_TITLE:title,
      AppData.TABLE_KEY_DESC:desc,
      AppData.TABLE_KEY_TIME:createAt,
    };
  }


}