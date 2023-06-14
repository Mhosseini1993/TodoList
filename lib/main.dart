import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Data/Models/Task.dart';
import 'package:todolist/Data/Source/HiveTaskDataSource.dart';
import 'Constants/Constants.dart';
import 'Screens/Home/MainPage.dart';
import 'Data/Repo/Repository.dart';

void main() async {
  // 1.init database
  await Hive.initFlutter();
  // 2.Register adapter
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());

  //3. Open Boxes
  await Hive.openBox<Task>(TaskBox);

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color(0XFF5C0AFF)));

  runApp(ChangeNotifierProvider<Repository<Task>>(
      create: (context)=>Repository<Task>(HiveTaskDataSource(Hive.box<Task>(TaskBox))),
      child: const ToDoListApp(),
    ),
  );
}

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(color: primaryTextColor),
              iconColor: primaryTextColor),
          scaffoldBackgroundColor: background,
          drawerTheme: const DrawerThemeData(
            backgroundColor: background,
          ),
          colorScheme: const ColorScheme.light().copyWith(
            primary: primary,
            onPrimary: onPrimary,
            primaryContainer: primaryContainer,
            background: background,
            onBackground: primaryTextColor,
            onSurface: primaryTextColor,
            secondary: primary,
            onSecondary: onSecondaryColor,
          )),
      home: MainPage(),
    );
  }
}
