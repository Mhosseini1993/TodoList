

//Data Source Layer, Data Provide
abstract class IDataSource<T>{

  Future<List<T>> getAll({String q=''});
  Future<List<T>> getTodayTasks();
  Future<T> getById(dynamic id);

  Future<void> deleteAll();
  Future<void> delete(T data);
  Future<void> deleteById(dynamic id);
  Future<void> deleteDailyTasks();

  Future<T> createOrUpdate(T data);
  Future<void> changeTaskStatus(T data);
}