
import 'dart:async';

import 'package:bloc_db/event.dart';
import 'package:bloc_db/noteModel.dart';
import 'package:bloc_db/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'db.dart';

class DbBloc extends Bloc<DbEvent,DbState>{
  AppData db;
  DbBloc({required this.db}):super(InitState()){
    on<addEvent>((event, emit) async{
      emit(CircularState());
      bool isNoteAdd= await db.addNote(newNote: event.noteModel);
      if(isNoteAdd){
        List<NoteModel>mData=await db.fecNote();
        emit(DataLoadState(allNotes: mData));
      }else{
        emit(ErrorState(msg: 'Note Not Add'));
      }
    });

    on<getEvent>((event, emit) async {
      emit(CircularState());
      List<NoteModel>mData=await db.fecNote();
      emit(DataLoadState(allNotes: mData));
    });

    on<upEvent>((event, emit)async{
      emit(CircularState());
     await Future.delayed(Duration(seconds: 2)).whenComplete(()async{
        bool isNoteUpdate = await db.upNotes(event.upNoteModel);
        if(isNoteUpdate){
          List<NoteModel>mData=await db.fecNote();
          emit(DataLoadState(allNotes: mData));
        }else{
          emit(ErrorState(msg: 'Note Not Update'));
        }
      });
      bool isNoteUpdate = await db.upNotes(event.upNoteModel);
      if(isNoteUpdate){
        List<NoteModel>mData=await db.fecNote();
        emit(DataLoadState(allNotes: mData));
      }else{
        emit(ErrorState(msg: 'Note Not Update'));
      }
    });

    on<deleteEvent>((event, emit)async {
      emit(CircularState());
      bool isDelete=await db.deleteNote(event.id);
      if(isDelete){
        List<NoteModel>mData=await db.fecNote();
        emit(DataLoadState(allNotes: mData));
      }else{
        emit(ErrorState(msg: 'Note Cannot Delete'));
      }
    });
  }

}