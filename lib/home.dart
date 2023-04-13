import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:todosapp/hive_db/hiveDb.dart';
import 'package:todosapp/todo_hiveDb/view.dart';

class HomePgae extends StatelessWidget {
  const HomePgae({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(onPressed: (){
              Get.to(HiveDb());
            },child: Text("Simple Hive Db",style: TextStyle(color: Colors.white),),color: Colors.blue,),
            MaterialButton(onPressed: (){
              Get.to(TodoApp());
            },child: Text("todo app",style: TextStyle(color: Colors.white),),color: Colors.blue,),
          ],
        ),
      ),
    );
  }
}