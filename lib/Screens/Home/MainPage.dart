import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Components/EmptyState.dart';
import 'package:todolist/Components/FirstListItem.dart';
import 'package:todolist/Constants/Constants.dart';
import 'package:todolist/Data/Models/Task.dart';
import 'package:todolist/Data/Repo/Repository.dart';
import 'package:todolist/Screens/HistoryPage.dart';
import 'package:todolist/Screens/Home/Bloc/home_bloc.dart';
import '../AddEditTaskPage.dart';
import '../../Components/TaskItemList.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('To Do List'),
              accountEmail: const Text('Manage Your Daily Tasks'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: theme.colorScheme.onPrimary,
                child: const Icon(CupertinoIcons.calendar_badge_minus),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => History(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.settings),
                          Padding(
                            padding: const EdgeInsets.only(left: 32),
                            child: Text(
                              'History',
                              style: theme.textTheme.headline6!
                                  .apply(fontSizeFactor: 0.8),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: MaterialButton(
                      onPressed: () => {},
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.chart_pie),
                          Padding(
                            padding: const EdgeInsets.only(left: 32),
                            child: Text(
                              'Chart',
                              style: theme.textTheme.headline6!
                                  .apply(fontSizeFactor: 0.8),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: MaterialButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(Icons.share),
                          Padding(
                            padding: const EdgeInsets.only(left: 32),
                            child: Text(
                              'Share',
                              style: theme.textTheme.headline6!
                                  .apply(fontSizeFactor: 0.8),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Change Theme',
                          style: theme.textTheme.headline6!
                              .apply(fontSizeFactor: 0.8),
                        ),
                        CupertinoSlidingSegmentedControl<ThemeModeEnum>(
                          thumbColor: Theme.of(context).primaryColor,
                          groupValue: ThemeModeEnum.Dark,
                          children: const {
                            ThemeModeEnum.Dark:
                                Icon(CupertinoIcons.moon_fill, size: 18.0),
                            ThemeModeEnum.Light:
                                Icon(CupertinoIcons.sun_max_fill, size: 18.0)
                          },
                          onValueChanged: (ThemeModeEnum? theme) {
                            // if (theme != null) _changeTheme(theme);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    onPressed: () => {},
                    child: Row(
                      children: [
                        const Icon(Icons.logout_outlined),
                        Padding(
                          padding: const EdgeInsets.only(left: 32),
                          child: Text(
                            'Close',
                            style: theme.textTheme.headline6!
                                .apply(fontSizeFactor: 0.8),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(context.read<Repository<Task>>()),
        child: Consumer<Repository<Task>>(builder: (context, repository, child) {
          context.read<HomeBloc>().add(HomeStarted());
          return BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: state.tasks.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index == 0
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: FirstListItem(),
                          )
                        : TaskItemList(
                            task: state.tasks.elementAt(index - 1),
                            EditTask: editTask,
                          );
                  },
                );
              } else if (state is HomeEmpty) {
                return const EmptyState();
              } else if (state is HomeLoading || state is HomeInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else {
                return const Text('not Defined');
              }
            },
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => AddEditTaskPage(
              task: Task(),
            ),
          ),
        ),
        label: const Text('Add New Task'),
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
