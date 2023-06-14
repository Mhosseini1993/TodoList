part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState{}

class HomeSuccess extends HomeState{
  final List<Task> tasks;
  HomeSuccess(this.tasks);
}

class HomeError extends HomeState{
  final String errorMessage;
  HomeError(this.errorMessage);
}

class HomeEmpty extends HomeState{}