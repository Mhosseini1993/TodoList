import 'package:hive_flutter/hive_flutter.dart';

part 'Task.g.dart';

@HiveType(typeId: 0) //0-223
class Task extends HiveObject {

  int id=-1;

  @HiveField(0)
  String title = '';

  @HiveField(1)
  bool isCompleted = false;

  @HiveField(2)
  DateTime doDate = DateTime.now();

  @HiveField(3)
  Priority priority = Priority.LOW;

}

@HiveType(typeId: 1)
enum Priority {
  @HiveField(0)
  LOW,
  @HiveField(1)
  MEDIUM,
  @HiveField(2)
  HIGH
}
