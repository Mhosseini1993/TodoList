import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/Data/Models/Task.dart';
import 'package:todolist/Data/Source/IDataSource.dart';

class HiveTaskDataSource implements IDataSource<Task> {
  final Box<Task> box;
  final DateTime dateNow =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  HiveTaskDataSource(this.box);

  @override
  Future<Task> createOrUpdate(Task data) async {
    if (data.isInBox) {
      data.save();
    } else {
      data.id = await box.add(data);
    }
    return data;
  }

  @override
  Future<void> delete(Task data) {
    return data.delete();
  }

  @override
  Future<void> deleteAll() {
    return box.clear();
  }

  @override
  Future<void> deleteById(id) {
    return box.delete(id);
  }

  @override
  Future<List<Task>> getAll({String q = ''}) async {
    return box.values.where((t) => t.title.contains(q)).toList();
  }

  @override
  Future<Task> getById(id) async {
    return box.values.where((t) => t.id == id).first;
  }

  @override
  Future<List<Task>> getTodayTasks() async {
    return box.values
        .where((t) => !t.isCompleted && t.doDate == dateNow)
        .toList();
  }

  @override
  Future<void> deleteDailyTasks() async {
    box.values.where((t) => t.doDate == dateNow).toList().forEach((element) {
      delete(element);
    });
  }

  @override
  Future<void> changeTaskStatus(Task data) async {
    data.isCompleted = !data.isCompleted;
    data.save();
  }
}
