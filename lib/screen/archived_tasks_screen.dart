import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_todo_app/component/task_item.dart';
import 'package:last_todo_app/data/cubit/cubit.dart';
import 'package:last_todo_app/data/cubit/states.dart';

class ArchiveTasksScreen extends StatelessWidget {
  const ArchiveTasksScreen({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppStates>(
      builder:(context, state) {
        final  cubit = AppCubit.i(context);
        if(cubit.archiveTasks.isEmpty){
          return  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.hourglass_empty),
                Text("No archive Tasks"),
              ],
            ),
          );
        }
        return  ListView.separated(itemBuilder: (context, index) =>  TaskItem(
            task:cubit.archiveTasks[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 10,),
            itemCount: cubit.archiveTasks.length);
      },

    );
  }
}
