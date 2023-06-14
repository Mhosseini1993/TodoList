import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(
            flex: 2,
            child: Lottie.asset('assets/notask.json',
                filterQuality: FilterQuality.high,
                repeat: true,
                fit: BoxFit.cover),
          ),
          Flexible(
              child: Text(
            'Your task list is empty',
            style: theme.textTheme.headline6,
          ))
        ],
      ),
    );
  }
}
