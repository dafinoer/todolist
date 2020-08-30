import 'package:todolist/api/task_collection.dart';
import 'package:todolist/model/task.dart';

class TaskRepository {
  final TaskCollection _collection = TaskCollection();

  Future<void> addNewTask(Task task) async {
    return _collection
        .addTask(task.toMap())
        .then((value) => print('writing task success'))
        .catchError((error) => print(error));
  }
}
