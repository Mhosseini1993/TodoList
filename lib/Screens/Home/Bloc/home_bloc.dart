import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todolist/Data/Models/Task.dart';
import 'package:todolist/Data/Repo/Repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //DI
  final Repository<Task> repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted) {
        emit(HomeLoading());
        try {
          final List<Task> tasks = await repository.getTodayTasks();
          if (tasks.isNotEmpty) {
            emit(HomeSuccess(tasks));
          } else {
            emit(HomeEmpty());
          }
        } catch (e) {
          emit(HomeError(e.toString()));
        }
      } else if (event is HistoryStarted || event is HomeTaskSearch) {
        emit(HomeLoading());
        String searchKey = '';
        if (event is HomeTaskSearch) {
          searchKey = event.searchKey;
        } else {
          searchKey = '';
        }
        try {
          final List<Task> tasks = await repository.getAll(q: searchKey);
          if (tasks.isNotEmpty) {
            emit(HomeSuccess(tasks));
          } else {
            emit(HomeEmpty());
          }
        } catch (e) {
          emit(HomeError(e.toString()));
        }
      } else if (event is HomeChangeTaskStatus) {
        await repository.changeTaskStatus(event.task);
      } else if (event is HomeDeleteDailyTasks) {
        await repository.deleteDailyTasks();
        emit(HomeEmpty());
      } else if (event is HomeDeleteTask) {
        await repository.delete(event.task);
      } else if(event is HomeAddEditTask){
        await repository.createOrUpdate(event.task);
      }
    });
  }
}
