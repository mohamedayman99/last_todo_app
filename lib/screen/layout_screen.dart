import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:last_todo_app/component/app_drawer.dart';
import 'package:last_todo_app/screen/add_task_bottom_sheet.dart';
import 'package:last_todo_app/screen/archived_tasks_screen.dart';
import 'package:last_todo_app/screen/done_tasks_screen.dart';
import 'package:last_todo_app/screen/new_tasks_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

int _currentIndex = 0;
String text = "NewTask";
Widget screen = const NewTasksScreen();

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: "new",
              backgroundColor: Colors.brown),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_all),
              label: "done",
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              label: "archive",
              backgroundColor: Colors.red),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            switch (index) {
              case 0:
                text = "new tasks";
                screen = const NewTasksScreen();
                break;
              case 1:
                text = "done tasks";
                screen = const DoneTasksScreen();
                break;
              default:
                text = "archive tasks";
                screen = const ArchiveTasksScreen();
            }
          });
        },
      ),
      drawer: const AppDrawer(),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark,
        ),
        title: Text(
          text,
          style: const TextStyle(color: Colors.blue),
        ),
      ),
      body: screen,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddTaskBottomSheet.push(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
