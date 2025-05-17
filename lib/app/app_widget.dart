import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/app/app_provider.dart';
import 'package:tasks/app/pages/home/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProvider.dependences,
      child: MaterialApp(
        title: 'Tarefas',
        theme: ThemeData.dark(),
        home: TasksPage(),
      ),
    );
  }
}
