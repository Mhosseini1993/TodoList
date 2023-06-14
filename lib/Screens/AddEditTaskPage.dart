import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Data/Repo/Repository.dart';
import '../Components/PriorityCheckBox.dart';
import '../Data/Models/Task.dart';
import '../Constants/Constants.dart';

class AddEditTaskPage extends StatefulWidget {
  Task task;

  AddEditTaskPage({Key? key, required this.task}) : super(key: key);

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final TextEditingController _txtTitle = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    _txtTitle.text = widget.task.title;
    selectedDate = widget.task.doDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task',
        ),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  'Priority',
                  style: theme.textTheme.headline6,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  width: 70,
                  height: 3,
                  color: theme.colorScheme.primary,
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  child: PriorityCheckBox(
                    color: priorityHighColor,
                    isChecked: widget.task.priority == Priority.HIGH,
                    title: 'HIGH',
                    onTap: () => setState(() {
                      widget.task.priority = Priority.HIGH;
                    }),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: PriorityCheckBox(
                    color: priorityMediumColor,
                    isChecked: widget.task.priority == Priority.MEDIUM,
                    title: 'MEDIUM',
                    onTap: () => setState(() {
                      widget.task.priority = Priority.MEDIUM;
                    }),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: PriorityCheckBox(
                    color: priorityLowColor,
                    isChecked: widget.task.priority == Priority.LOW,
                    title: 'LOW',
                    onTap: () => setState(() {
                      widget.task.priority = Priority.LOW;
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _txtTitle,
              decoration: const InputDecoration(
                  label: Text('Title'),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.task_alt_rounded,
                    size: 16,
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Do Date : ',
                        style: theme.textTheme.headline6,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          selectedDate.toString().substring(0, 10),
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () => selectDate(context),
                  color: theme.colorScheme.primary,
                  child: Row(
                    children: [
                      const Text('Choose Date'),
                      const SizedBox(
                        width: 4,
                      ),
                      Icon(
                        CupertinoIcons.calendar_today,
                        size: 18,
                        color: theme.colorScheme.onPrimary,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => addEditTask(context, _txtTitle.text),
        label: Row(
          children: const [
            Text('Save changes'),
            SizedBox(
              width: 4,
            ),
            Icon(
              CupertinoIcons.check_mark,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Future selectDate(BuildContext context) async {
    DateTime dtNow = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dtNow,
      firstDate: DateTime(dtNow.year, dtNow.month, dtNow.day),
      lastDate: DateTime(2101, 1, 1),
    );
    if (picked != null && picked != selectedDate) {
      setState(
        () {
          selectedDate = picked;
        },
      );
    }
  }

  void addEditTask(BuildContext context, String title) {
    ThemeData theme = Theme.of(context);
    if (title.isEmpty) {
      SnackBar snack = SnackBar(
        content: Text(
          'Title can not be empty',
          style: theme.textTheme.bodyText1!
              .apply(color: theme.colorScheme.onPrimary),
        ),
        backgroundColor: theme.colorScheme.primary,
        duration: const Duration(milliseconds: 750),
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    } else {
      widget.task.title = title;
      widget.task.doDate = selectedDate!;
      Repository<Task> repository= Provider.of<Repository<Task>>(context,listen: false);
      repository.createOrUpdate(widget.task);
      Navigator.of(context).pop();
    }
  }
}
