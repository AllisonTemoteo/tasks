sealed class Task {
  const Task({required this.title, required this.isDone});
  final String title;
  final bool isDone;
}

class NewTask extends Task {
  NewTask({required super.title, super.isDone = false});
}

class SavedTask extends Task {
  SavedTask({required this.id, required super.title, required super.isDone});

  SavedTask.fromNewTask(NewTask task, {required this.id})
    : super(title: task.title, isDone: task.isDone);

  final int id;

  SavedTask copyWith({int? id, String? title, bool? isDone}) {
    return SavedTask(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
