
import 'package:bloc_db/bloc.dart';
import 'package:bloc_db/event.dart';
import 'package:bloc_db/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var Df=DateFormat.Hm();
  @override
  void initState() {
    super.initState();
    context.read<DbBloc>().add(getEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc List'),
        backgroundColor: Colors.orange,
      ),
      body: BlocBuilder<DbBloc,DbState>(
        builder: (_,state){
          if(state is CircularState){
            return Center(child: CircularProgressIndicator(),);
          }else if(state is ErrorState){
            return Center(child: Text('${state.msg}'),);
          }else if(state is DataLoadState){
           var mData= state.allNotes;
           return ListView.builder(
             itemCount: mData.length,
             itemBuilder: (context, index) {
               return ListTile(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage(isUpdate: true,myModel: mData[index],),));
                 },
                 title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(mData[index].title),
                     InkWell(
                         onTap: (){
                           context.read<DbBloc>().add(deleteEvent(id: mData[index].id));
                         },
                         child: Icon(Icons.delete,color: Colors.orange,)),

                   ],
                 ),
                 subtitle: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(mData[index].desc),
                     Text(Df.format(DateTime.fromMillisecondsSinceEpoch(int.parse(mData[index].createAt)))),

                   ],
                 ),
               );
             },);
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage(),));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
