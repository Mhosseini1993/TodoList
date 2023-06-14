//Generic Repository.
//Repository Layer
import 'package:flutter/foundation.dart';
import 'package:todolist/Data/Source/IDataSource.dart';

/// تصمیم بگیرد دیتا را از کدام دیتاسورس بیاورد
class Repository<T> extends ChangeNotifier implements IDataSource<T> {
  final IDataSource<T> hiveDB;

  Repository(this.hiveDB);

  @override
  Future<T> createOrUpdate(T data) async {
    T result = await hiveDB.createOrUpdate(data);
    notifyListeners();
    return result;
  }

  @override
  Future<void> delete(T data) async {
    hiveDB.delete(data);
    notifyListeners();
    return;
  }

  @override
  Future<void> deleteAll() async {
    hiveDB.deleteAll();
    notifyListeners();
    return;
  }

  @override
  Future<void> deleteById(id) async {
    hiveDB.deleteById(id);
    notifyListeners();
    return;
  }

  @override
  Future<List<T>> getAll({String q = ''}) {
    return hiveDB.getAll(q: q);
  }

  @override
  Future<T> getById(id) {
    return hiveDB.getById(id);
  }

  @override
  Future<List<T>> getTodayTasks() {
    return hiveDB.getTodayTasks();
  }

  @override
  Future<void> deleteDailyTasks() async {
    hiveDB.deleteDailyTasks();
    notifyListeners();
    return;
  }

  @override
  Future<void> changeTaskStatus(T data) async {
    hiveDB.changeTaskStatus(data);
    notifyListeners();
  }
}
