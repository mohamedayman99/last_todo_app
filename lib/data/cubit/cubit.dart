import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_todo_app/data/cubit/states.dart';
import 'package:last_todo_app/data/local_data_source/sqflight.dart';
import 'package:last_todo_app/model/task_model.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialStates());

  static AppCubit i(BuildContext context) => BlocProvider.of<AppCubit>(context);
  List <TaskModel> tasks = [];
  List <TaskModel> doneTasks = [];
  List <TaskModel> archiveTasks = [];
  final LocalDataSource _dataSource = LocalDataSource();
  void restTasks(){
    tasks = [];
    doneTasks = [];
    archiveTasks = [];
  }


 Future <void> insetIntoDatabase({
    required String title,
    required String time,
    required String date,
  })async{
  try{
    await _dataSource.insertIntoDatabase(title:title, time:time , date:date );

    getData();
    }
    catch(e){
    rethrow;
    }
  }

Future<void> getData()async{
  restTasks();
final res =  await _dataSource.getData();
res.forEach((element) {
  setTasks(element);
});
emit(GetDataState());
}

void setTasks(Map<String,dynamic> task){
   final taskModel =TaskModel.fromJson(task);
   final status =task["status"];
   if(status == "new"){
     tasks.add(taskModel);
   }else if (status == "done"){
     doneTasks.add(taskModel);
   }else{
     archiveTasks.add(taskModel);
   }
}


Future<void> updateData({required String status,required int id})async{
   await _dataSource.updateDatabase(status:status , id: id);
   getData();
}
  Future<void> deleteData({required int id})async{
    await _dataSource.deleteDatabase(id: id);
    getData();
  }

}