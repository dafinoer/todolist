import 'package:todolist/api/task_service.dart';
import 'package:todolist/model/task.dart';

class TaskRepository {
  TaskService _services;

  TaskRepository(TaskService service) {
    this._services = service;
  }

  Future<void> addNewTask(Task task) async {
    return _services
        .addTask(task.toMap())
        .then((value) => print('writing task success'))
        .catchError((error) => print(error));
  }

  Future<void> deleteTask(String idDoc) async {
    await _services.deleteTask(idDoc);
    return;
  }
}
