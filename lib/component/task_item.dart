import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_todo_app/data/cubit/cubit.dart';
import 'package:last_todo_app/data/cubit/states.dart';
import 'package:last_todo_app/model/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({Key? key, required this.task}) : super(key: key);
  final TaskModel task ;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppStates>(
      builder: (context, state) => Dismissible(
        key: Key(task.id.toString()),
        onDismissed: (direction) {
          AppCubit.i(context).deleteData(id: task.id!);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 80,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children:  [
              CircleAvatar(
                child: Text("${task.id}"),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    task.title!,
                    style: const TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    children:  [
                      Text(
                        task.time!,
                        style: const TextStyle(color: Colors.white, fontSize: 12,),
                      ),
                      const SizedBox(width: 20,),
                      Text(
                        task.date!,
                        style: const TextStyle(color: Colors.white, fontSize: 12,),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              if(task.status!= "done")
              IconButton(onPressed: (){
                AppCubit.i(context).updateData(id: task.id!,status: "done");
              }, icon: const Icon(Icons.done),color: Colors.white),
              if(task.status!= "archive")
                IconButton(onPressed: (){
                AppCubit.i(context).updateData(id: task.id!,status: "archive");
              }, icon: const Icon(Icons.archive),color: Colors.white,),
            ],
          ),
        ),
      ),
    );
  }
}
