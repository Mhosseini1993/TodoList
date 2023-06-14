import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Components/CustomCheckBox.dart';
import 'package:todolist/Constants/Constants.dart';
import 'package:todolist/Data/Models/Task.dart';
import 'package:todolist/Screens/Home/Bloc/home_bloc.dart';

class TaskItemList extends StatefulWidget {
  final Task task;
  final void Function(BuildContext context, Task task) EditTask;

  const TaskItemList({Key? key, required this.task, required this.EditTask})
      : super(key: key);

  @override
  State<TaskItemList> createState() => _TaskItemListState();
}

class _TaskItemListState extends State<TaskItemList> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onLongPress: () {
        AlertDialog dg = AlertDialog(
          title: const Text('Info'),
          content: const Text('Are you sure about deleting this task?'),
          actions: [
            TextButton(
              onPressed: () => {Navigator.of(context).pop()},
              child: const Text('No'),
            ),
          TextButton(
                onPressed: () {
                  context.read<HomeBloc>().add(HomeDeleteTask(widget.task));
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              )
          ],
        );
        showDialog(context: context, builder: (context) => dg);
      },
      onTap: () => widget.EditTask(context, widget.task),
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.2))
          ],
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            CustomCheckBox(
                isCompleted: widget.task.isCompleted,
                checkChange: () {
                  AlertDialog dg = AlertDialog(
                    title: const Text('Info'),
                    content: const Text(
                        'Are you sure about changing the task status?'),
                    actions: [
                      TextButton(
                        onPressed: () => {Navigator.of(context).pop()},
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () => setState(() {
                          context.read<HomeBloc>().add(HomeChangeTaskStatus(widget.task));
                          Navigator.of(context).pop();
                        }),
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                  showDialog(context: context, builder: (context) => dg);
                }),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                widget.task.title.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            ),
            Container(
              width: 10,
              decoration: BoxDecoration(
                color: (widget.task.priority == Priority.HIGH)
                    ? priorityHighColor
                    : (widget.task.priority == Priority.MEDIUM)
                        ? priorityMediumColor
                        : priorityLowColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
