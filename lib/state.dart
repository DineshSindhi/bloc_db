import 'package:bloc_db/noteModel.dart';

abstract class DbState{}

class CircularState extends DbState{


}
class InitState extends DbState{}

class DataLoadState extends DbState{
  List<NoteModel> allNotes=[];
  DataLoadState({required this.allNotes});
}
class ErrorState extends DbState{
  String msg;
  ErrorState({required this.msg});
}