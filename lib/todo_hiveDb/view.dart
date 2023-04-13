import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todosapp/boxes/boxes.dart';
import 'package:todosapp/model/todo_hive_model.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final titleController=TextEditingController();
  final desController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      // color: Colors.amber,
      // fallbackHeight: 300,
      child:Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          add_data_dialog(context);
       
        },child: Icon(Icons.add),),
        appBar: AppBar(
          title: Text("Todo App with Hive DB"),
        ),
        body: ValueListenableBuilder(
          valueListenable: Boxes.getdata().listenable(), 
        builder: (context,box,_){
          var data=box.values.toList().cast<TodoHiveModel>();
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context,index){
              return Card(
            child: ListTile(
              title: Text(data[index].title.toString()),
              subtitle: Text(data[index].des.toString()),
              trailing: Container(
                height: 100,
                width: 110,
                child: Row(
                  
                  children: [
                    IconButton(onPressed: (){
                      Edit_data_dialog(context, data[index], data[index].title.toString(), data[index].des.toString());
                       
                    }, icon: Icon(Icons.edit)),
                    IconButton(onPressed: (){
                      delete(data[index]);
                    }, icon: Icon(Icons.delete,color: Colors.red,))
                  ],
                ),
              ),
            ),

          );
            },
          );
        }),
      )
    );
  }
 Future<dynamic> Edit_data_dialog(BuildContext context,TodoHiveModel todoHiveModel,String title, String des) {
  titleController.text=title;
  desController.text=des;
    return showDialog(context: context, builder: (context){
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "title",
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 10,),
                   TextFormField(
                  controller: desController,
                    decoration: InputDecoration(
                      hintText: "Des",
                      border: OutlineInputBorder()
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: ()async{
              todoHiveModel.title=titleController.text.toString();
              todoHiveModel.des=desController.text.toString();
              todoHiveModel.save();
              titleController.clear();
              desController.clear();
              Get.back();
              }, child: Text("Add")),
              TextButton(onPressed: (){
                Get.back();
              }, child: Text("Cencel")),
            ],
          );
        });
  }
  
  Future<dynamic> add_data_dialog(BuildContext context) {
    return showDialog(context: context, builder: (context){
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "title",
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 10,),
                   TextFormField(
                  controller: desController,
                    decoration: InputDecoration(
                      hintText: "Des",
                      border: OutlineInputBorder()
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: ()async{
                var data=TodoHiveModel(title: titleController.text.toString(), des: desController.text.toString());
                final box=await Boxes.getdata();
               box.add(data);
               data.save();
               titleController.clear();
               desController.clear();
              Get.back();
              }, child: Text("Add")),
              TextButton(onPressed: (){
                Get.back();
              }, child: Text("Cencel")),
            ],
          );
        });
  }
  
  void delete(TodoHiveModel todoHiveModel)async{
    await todoHiveModel.delete();
  }
}