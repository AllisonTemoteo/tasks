import 'package:tasks/app/utils/validating/task_title.dart';

abstract class TaskValidator {
  static String? taskTitleValidate(String? value) {
    if (value == null) {
      return 'O campo não pode estar vazio';
    }

    return TaskTitle(value).validate();
  }
}
