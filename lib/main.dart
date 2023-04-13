import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todosapp/home.dart';
import 'package:todosapp/model/todo_hive_model.dart';
import 'package:todosapp/todo_hiveDb/view.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 var directory=await getApplicationDocumentsDirectory();
 
   Hive.init(directory.path);
   Hive.registerAdapter(TodoHiveModelAdapter());
 await  Hive.openBox<TodoHiveModel>("todoapp");

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home:HomePgae()
    );
  }
}