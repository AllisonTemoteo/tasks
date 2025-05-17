import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/app/data/models/task.dart';
import 'package:tasks/app/pages/components/task/task_form.dart';
import 'package:tasks/app/pages/components/task/task_view_model.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({super.key});

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<TaskViewModel>().listTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskVM = Provider.of<TaskViewModel>(context);

    if (taskVM.tasks.isEmpty) {
      return Center(child: Text('Nenhuma tarefa criada'));
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: taskVM.tasks.length,
          itemBuilder: (ctx, index) {
            final task = taskVM.tasks[index];
            return TaskListItem(task: task, index: index, taskVM: taskVM);
          },
        ),
      );
    }
  }
}

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.task,
    required this.index,
    required this.taskVM,
  });

  final SavedTask task;
  final int index;
  final TaskViewModel taskVM;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.title),
        leading: Checkbox(
          value: task.isDone,
          onChanged: _changeTaskIsDoneAction,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _updateTaskAction(context),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: _deleteTaskActionAction,
            ),
          ],
        ),
      ),
    );
  }

  void _changeTaskIsDoneAction(value) {
    taskVM.changeTaskIsDone(value, task);
  }

  void _updateTaskAction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => TaskFormWidget(updatingTask: task),
    );
  }

  void _deleteTaskActionAction() {
    taskVM.removeTask(task);
  }
}
