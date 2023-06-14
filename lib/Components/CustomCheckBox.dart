import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Constants/Constants.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isCompleted;
  final Function() checkChange;

  const CustomCheckBox({Key? key, required this.isCompleted, required this.checkChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: checkChange,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: !isCompleted
                ? Border.all(width: 2, color: secondaryTextColor)
                : null,
            color: isCompleted
                ? theme.colorScheme.primary
                : theme.colorScheme.onPrimary),
        child: isCompleted
            ? Icon(
                CupertinoIcons.check_mark,
                size: 16,
                color: theme.colorScheme.onPrimary,
              )
            : null,
      ),
    );
  }
}
