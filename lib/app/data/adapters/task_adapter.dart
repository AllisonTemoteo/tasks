import 'package:tasks/app/data/models/task.dart';

abstract class TaskAdapter {
  static const String cId = 'taskId';
  static const String cTitle = 'title';
  static const String cIsDone = 'isDone';

  static SavedTask fromMap(Map<String, Object?> data) {
    return SavedTask(
      id: data[cId] as int,
      title: data[cTitle] as String,
      isDone: data[cIsDone] == 1,
    );
  }
}
