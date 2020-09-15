


import 'package:todolist/api/firestore_service.dart';
import 'package:todolist/model/task.dart';

class AddRepository {

  final _service = FirestoreService('task');

  Future<void> addNewTask(Task task) async {
    return _service
        .addTask(task.toMap())
        .then((value) => print('writing task success'))
        .catchError((error) => print(error));
  }

  Future<void> editTask(Map data, String docName) async {
    try {
      await isDoneChecklist(data, docName);
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> isDoneChecklist(Map data, String docName) async {
    try {
      await _service.updateTask(data, docName);
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  String get getId => this._service.getId();

}