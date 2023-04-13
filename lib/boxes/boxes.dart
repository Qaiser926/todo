import 'package:todosapp/model/todo_hive_model.dart';
import 'package:hive/hive.dart';
class Boxes{

static Box<TodoHiveModel> getdata()=> Hive.box("todoapp");
}