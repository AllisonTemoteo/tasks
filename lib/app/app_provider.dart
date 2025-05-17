import 'package:provider/provider.dart';
import 'package:tasks/app/data/models/task_repository.dart';
import 'package:tasks/app/data/repositories/task_local_repository.dart';
import 'package:tasks/app/data/services/storage/sqlite/sqflite_helper.dart';
import 'package:tasks/app/pages/components/task/task_view_model.dart';

abstract class AppProvider {
  static final dependences = [
    Provider<SqfliteDesktopHelper>(create: (_) => SqfliteDesktopHelper()),

    ProxyProvider<SqfliteDesktopHelper, TaskRepository>(
      update: (_, storage, _) => TaskLocalRepository(storage),
    ),

    ChangeNotifierProxyProvider<TaskRepository, TaskViewModel>(
      create: (ctx) => TaskViewModel(),
      update: (_, repo, vm) => vm!..initTaskViewModel(repo),
    ),
  ];
}
