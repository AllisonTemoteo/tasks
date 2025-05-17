import 'package:tasks/app/data/adapters/task_adapter.dart';
import 'package:tasks/app/data/models/task.dart';
import 'package:tasks/app/data/models/task_repository.dart';
import 'package:tasks/app/data/services/storage/sqlite/sqflite_helper.dart';

class TaskLocalRepository implements TaskRepository {
  const TaskLocalRepository(SqfliteDesktopHelper storage) : _storage = storage;
  final SqfliteDesktopHelper _storage;

  @override
  Future<List<SavedTask>> query() async {
    final db = await _storage.database;

    var sql = '''SELECT * FROM task''';
    final tasks = await db.rawQuery(sql);

    if (tasks.isEmpty) {
      return [];
    }

    return tasks.map((task) => TaskAdapter.fromMap(task)).toList();
  }

  @override
  Future<SavedTask> create(NewTask task) async {
    final db = await _storage.database;

    String sql = '''INSERT INTO task (title, isDone) 
           VALUES ('${task.title}', ${task.isDone})''';

    final id = await db.rawInsert(sql);

    return SavedTask.fromNewTask(task, id: id);
  }

  @override
  Future<SavedTask> delete(SavedTask task) async {
    final db = await _storage.database;

    String sql = '''DELETE FROM task WHERE taskId = ${task.id}''';

    await db.rawDelete(sql);

    return task;
  }

  @override
  Future<SavedTask> update(SavedTask task) async {
    final db = await _storage.database;

    String sql = '''UPDATE task SET title = '${task.title}', 
                           isDone = ${task.isDone} 
            WHERE taskId = ${task.id};''';

    await db.rawUpdate(sql);
    return task;
  }
}
