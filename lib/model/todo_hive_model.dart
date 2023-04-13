
import 'package:hive/hive.dart';
part 'todo_hive_model.g.dart';

@HiveType(typeId: 0)
class TodoHiveModel extends HiveObject{
@HiveField(1)
  String title;
  @HiveField(2)
  String des;
  TodoHiveModel({
    required this.title,required this.des
  });
}