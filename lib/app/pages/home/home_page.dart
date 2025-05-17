import 'package:flutter/material.dart';
import 'package:tasks/app/pages/components/task/task_form.dart';
import 'package:tasks/app/pages/components/task/task_list.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de tarefas'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(children: [TaskListWidget()]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTaskFormModal(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _openTaskFormModal(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => TaskFormWidget());
  }
}
