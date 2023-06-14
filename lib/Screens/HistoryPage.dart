import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Components/EmptyState.dart';
import 'package:todolist/Components/TaskItemList.dart';
import 'package:todolist/Data/Models/Task.dart';
import 'package:todolist/Data/Repo/Repository.dart';
import 'package:todolist/Screens/AddEditTaskPage.dart';
import 'package:todolist/Screens/Home/Bloc/home_bloc.dart';

class History extends StatelessWidget {
  History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(context.read<Repository<Task>>()),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primaryContainer
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () => {Navigator.pop(context)},
                              icon: Icon(
                                CupertinoIcons.back,
                                size: 18,
                                color: theme.colorScheme.onSecondary,
                              )),
                          Text(
                            'To Do List',
                            style: theme.textTheme.headline6!
                                .apply(color: theme.colorScheme.onSecondary),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20)
                        ]),
                        child: Builder(
                          builder: (context) {
                            return TextField(
                              onChanged: (String q) {
                                context
                                    .read<HomeBloc>()
                                    .add(HomeTaskSearch(q));
                              },
                              decoration: InputDecoration(
                                label: const Text('Search in all tasks ...'),
                                prefixIcon: const Icon(CupertinoIcons.search),
                                filled: true,
                                fillColor: theme.colorScheme.onPrimary,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(19),
                                  borderSide: BorderSide(
                                      color: theme.colorScheme.primary),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(19),
                                  borderSide: BorderSide(
                                      color: theme.colorScheme.primary),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Consumer<Repository<Task>>(
                  builder: (context, repository, child) {
                    context.read<HomeBloc>().add(HistoryStarted());
                    return BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is HomeInitial ||
                            state is HomeInitial) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is HomeSuccess) {
                          return ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: state.tasks.length,
                            itemBuilder: (BuildContext context, int index) {
                              return TaskItemList(
                                task: state.tasks.elementAt(index),
                                EditTask: editTask,
                              );
                            },
                          );
                        } else if (state is HomeError) {
                          return Center(
                            child: Text(state.errorMessage),
                          );
                        } else if (state is HomeEmpty) {
                          return const EmptyState();
                        } else {
                          return const Text('not Defined');
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editTask(BuildContext context, Task task) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => AddEditTaskPage(
          task: task,
        ),
      ),
    );
  }
}
