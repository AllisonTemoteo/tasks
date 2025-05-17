import 'package:tasks/app/utils/validating/validatable_object.dart';

class TaskTitle extends ValidatableObject<String> {
  TaskTitle(super.value);

  @override
  String? validate() {
    if (value.trim().isEmpty) {
      return 'Informe o titulo da tarefa';
    }

    return null;
  }
}
