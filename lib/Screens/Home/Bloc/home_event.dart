part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeStarted extends HomeEvent {}

class HistoryStarted extends HomeEvent {}

class HomeDeleteDailyTasks extends HomeEvent {}

class HomeTaskSearch extends HomeEvent {
  final String searchKey;

  HomeTaskSearch(this.searchKey);
}

class HomeDeleteTask extends HomeEvent {
  final Task task;

  HomeDeleteTask(this.task);
}

class HomeChangeTaskStatus extends HomeEvent {
  final Task task;

  HomeChangeTaskStatus(this.task);
}

class HomeAddEditTask extends HomeEvent{
  final Task task;

  HomeAddEditTask(this.task);
}