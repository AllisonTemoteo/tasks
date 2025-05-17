import 'package:tasks/app/data/models/task.dart';

abstract class TaskRepository {
  Future<List<SavedTask>> query();
  Future<SavedTask> create(NewTask task);
  Future<SavedTask> update(SavedTask task);
  Future<SavedTask> delete(SavedTask task);
}
