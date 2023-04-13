import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive/hive.dart';

class HiveDb extends StatelessWidget {
  const HiveDb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: ()async{

       final hiveDb=await Hive.openBox("notes");

       hiveDb.put("name","Qaiser");
       hiveDb.put("last name","Farooq");
       hiveDb.put("my love","Safa");
       print(hiveDb.get("my love"));
      },child:Icon(Icons.add),),
      appBar: AppBar(
        title: Text("Hive Database"),
      ),
      body: FutureBuilder(
        future:Hive.openBox("notes") ,
        
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          return ListTile(
            title: Text(snapshot.data!.get("name").toString()),
            subtitle: Text(snapshot.data!.get("last name").toString()),   
            trailing: Container(
              height: 100,
              width: 90,
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                   snapshot.data!.put("name", "Qaiser farooq");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.edit),
                    )),
                  InkWell(
                    onTap: (){
                       snapshot.data!.delete("name",);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.delete_forever),
                    ),
                  ),
                ],
              ),
            ),         
          );
        },
      ),
    );
  }
}