import 'package:flutter/material.dart';
import 'package:tasks/app/data/models/task.dart';
import 'package:tasks/app/data/models/task_repository.dart';
import 'package:tasks/app/utils/validating/task_title.dart';

class TaskViewModel extends ChangeNotifier {
  late TaskRepository _taskRepository;

  List<SavedTask> _tasks = [];

  List<SavedTask> get tasks => _tasks;

  Future<void> initTaskViewModel(TaskRepository repo) async {
    _taskRepository = repo;
  }

  Future<void> listTasks() async {
    _tasks = await _taskRepository.query();
    notifyListeners();
  }

  Future<void> addTask(TaskTitle title) async {
    final newTask = NewTask(title: title.value);
    final savedTask = await _taskRepository.create(newTask);

    _tasks.add(savedTask);

    notifyListeners();
  }

  Future<void> changeTaskIsDone(bool value, SavedTask task) async {
    await updateTask(task.copyWith(isDone: value));
  }

  Future<void> updateTask(SavedTask task) async {
    final newTask = await _taskRepository.update(task);

    final taskIndex = _tasks.indexWhere((e) => e.id == task.id);
    _tasks[taskIndex] = newTask;

    notifyListeners();
  }

  Future<void> removeTask(SavedTask task) async {
    final result = await _taskRepository.delete(task);
    _tasks.removeWhere((e) => e.id == result.id);
    notifyListeners();
  }
}
