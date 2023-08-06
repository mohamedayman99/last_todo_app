import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_todo_app/data/cubit/cubit.dart';
import 'package:last_todo_app/data/local_data_source/sqflight.dart';
import 'package:last_todo_app/screen/layout_screen.dart';
import 'package:last_todo_app/screen/splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await LocalDataSource().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) => AppCubit()..getData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        ),
        debugShowCheckedModeBanner: false,
        home:    const SplashScreen(),
      ),
    );
  }
}

