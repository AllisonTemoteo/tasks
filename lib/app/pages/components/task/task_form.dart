import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/app/data/models/task.dart';
import 'package:tasks/app/pages/components/task/task_validator.dart';
import 'package:tasks/app/pages/components/task/task_view_model.dart';
import 'package:tasks/app/utils/validating/task_title.dart';

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({super.key, this.updatingTask});
  final SavedTask? updatingTask;

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String formTitleText = 'Nova Tarefa';
    String confirmButtonText = 'Adicionar';
    void Function(BuildContext) formButtonAction = _addTaskAction;

    if (widget.updatingTask != null) {
      _controller.text = widget.updatingTask!.title;
      formTitleText = 'Editar Tarefa';
      confirmButtonText = 'Salvar';
      formButtonAction = _updateTaskAction;
    }

    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(formTitleText, style: Theme.of(context).textTheme.titleLarge),
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Titulo'),
              validator: TaskValidator.taskTitleValidate,
            ),
            SizedBox(height: 25),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => formButtonAction(context),
                child: Text(confirmButtonText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addTaskAction(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final taskVM = context.read<TaskViewModel>();
      taskVM.addTask(TaskTitle(_controller.text));
    }
  }

  void _updateTaskAction(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final taskVM = context.read<TaskViewModel>();
      final newTask = widget.updatingTask!.copyWith(title: _controller.text);
      taskVM.updateTask(newTask);
    }
  }
}
