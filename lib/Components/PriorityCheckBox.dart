import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/Data/Models/Task.dart';
import '../Constants/Constants.dart';

class PriorityCheckBox extends StatelessWidget {
  final bool isChecked;
  final Color color;
  final String title;
  final void Function() onTap;

  const PriorityCheckBox(
      {Key? key,
      required this.color,
      required this.isChecked,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 4, left: 4),
      child: MaterialButton(
        onPressed: onTap,
        elevation: 10,
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: theme.textTheme.bodyText1,
                ),
              ),
            ),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: color,
              ),
              child: isChecked
                  ? const Icon(
                      CupertinoIcons.check_mark,
                      size: 12,
                      color: onPrimary,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
