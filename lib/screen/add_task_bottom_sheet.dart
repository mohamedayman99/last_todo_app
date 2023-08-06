import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:last_todo_app/component/app_text_field.dart';
import 'package:last_todo_app/data/cubit/cubit.dart';
import 'package:last_todo_app/model/task_model.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({Key? key}) : super(key: key);


  static void push(BuildContext context) {
    showModalBottomSheet(context: context,
      builder: (context) => AddTaskBottomSheet(),);
  }

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  var timeController = TextEditingController();

  var dateController = TextEditingController();

  void onPressed() {
    if(formKey.currentState!.validate()){
      AppCubit.i(context).insetIntoDatabase(
          title: titleController.text,
          time: timeController.text,
          date: dateController.text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.i(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
          AppTextField(
            controller: titleController,
          validator: (value){
              if(value!.isEmpty){
                return "title is required";
              }
              return null ;
          },
          label: const Text("task title"),
          prefixIcon: const Icon(Icons.title_outlined),

        ),
        const SizedBox(height: 10,),
        AppTextField(
          controller: timeController,
          validator: (value){
          if(value!.isEmpty){
            return "time is required";
          }
          return null ;
        },

          label: const Text("time title",),
          prefixIcon: const Icon(Icons.timer),
          readonly: true,
          onTab: () async {
            TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now());
            if (time != null) {
              timeController.text = time.format(context);
            }
          },
        ),
        const SizedBox(height: 10,),
        AppTextField(
          controller: dateController,
          validator: (value){
            if(value!.isEmpty){
              return "date is required";
            }
            return null ;
          },
          label: const Text("date title"),
          prefixIcon: const Icon(Icons.date_range),
          readonly: true,
          onTab: () async {
            final DateTime? date = await showDatePicker(context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365 * 5),),);
            if (date != null) {
              var format = DateFormat.yMMMd();
              dateController.text = format.format(date);
            }
          },
        ),
        const Spacer(),
        ElevatedButton.icon(onPressed: onPressed,
            label: const Text("add"),
        icon: const Icon(Icons.add),
    )],
    ),
      )
    ,
    );
  }
}

