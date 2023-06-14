import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Screens/Home/Bloc/home_bloc.dart';

class FirstListItem extends StatelessWidget {
  FirstListItem({Key? key}) : super(key: key);
  final DateTime dateNow =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: theme.textTheme.headline6!.apply(fontSizeFactor: 0.8),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              width: 50,
              height: 6,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
        MaterialButton(
          onPressed: () {
            AlertDialog dg = AlertDialog(
              title: const Text('Info'),
              content: const Text('Are you sure about deleting today tasks?'),
              actions: [
                TextButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(HomeDeleteDailyTasks());
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
            showDialog(context: context, builder: (context) => dg);
          },
          elevation: 2,
          color: const Color(0xffEAEFF5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delete All',
                style: theme.textTheme.subtitle2,
              ),
              const SizedBox(
                width: 4,
              ),
              Icon(
                CupertinoIcons.delete_solid,
                size: 16,
                color: Colors.red.withOpacity(0.8),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
