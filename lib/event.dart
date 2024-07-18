import 'noteModel.dart';

abstract class DbEvent{}
class getEvent extends DbEvent{}
class addEvent extends DbEvent{
  NoteModel noteModel;
  addEvent({required this.noteModel});
}
class upEvent extends DbEvent{
  NoteModel upNoteModel;
  upEvent({required this.upNoteModel});
}
class deleteEvent extends DbEvent{
  int id;
  deleteEvent({required this.id});
}