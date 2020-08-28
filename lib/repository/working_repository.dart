import 'package:todolist/api/working_collection.dart';
import 'package:todolist/model/task.dart';

class WorkingRepository {
  final WorkingCollection _workingCollection = WorkingCollection();

  Future<void> add(Task task) async {
    return _workingCollection
        .addWorkingTask(task.toMap())
        .then((value) => print('sucess'))
        .catchError((e) => throw Exception(e));
  }
}
