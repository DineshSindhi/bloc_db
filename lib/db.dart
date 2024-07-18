import 'package:bloc_db/noteModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppData{

  AppData._();
  static final AppData db=AppData._();

  static const String TABLE_KEY_NOTE ='note';
  static const String TABLE_KEY_ID ='id';
  static const String TABLE_KEY_TITLE ='title';
  static const String TABLE_KEY_DESC ='desc';
  static const String TABLE_KEY_TIME ='time';

  Database? myDb;

  Future<Database> getDb()async{
    if(myDb!=null){
      return myDb!;
    }else{
     myDb=await initDb();
     return myDb!;
    }
  }

  Future<Database> initDb()async{

    var root=await getApplicationDocumentsDirectory();
    var mainRoot=join(root.path,'Todo.db');
    return openDatabase(mainRoot, version: 1,onCreate: (db,version){
      db.execute(' create table $TABLE_KEY_NOTE ( $TABLE_KEY_ID integer primary key autoincrement,$TABLE_KEY_TITLE text,$TABLE_KEY_DESC text,$TABLE_KEY_TIME text )');

    });
  }

  Future<bool> addNote({required NoteModel newNote})async{
    var db=await getDb();
    var check= await db.insert('$TABLE_KEY_NOTE',newNote.toMap() );
    return check>0;
  }
  Future<List<NoteModel>>fecNote()async{
    var db=await getDb();
    var data=await db.query('$TABLE_KEY_NOTE');
    List<NoteModel>mData=[];
    for(Map<String, dynamic >  eachData in data){
      var eachNote=NoteModel.fromMap(eachData);
      mData.add(eachNote);
    }
    return mData;
  }

   Future<bool>upNotes(NoteModel upNote)async{
    var db=await getDb();
   int check=await db.update('$TABLE_KEY_NOTE',upNote.toMap(),
    where: '$TABLE_KEY_ID=?',whereArgs: ['${upNote.id}']
    );
    return check>0;
  }
  Future<bool>deleteNote(int id)async{
    var db=await getDb();
   var check=await db.delete('$TABLE_KEY_NOTE',
    where: '$TABLE_KEY_ID=?',whereArgs: ['$id']
    );
   return check>0;
  }

}