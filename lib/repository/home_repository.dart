import 'dart:collection';
import 'package:todolist/api/firestore_service.dart';
import 'package:todolist/model/task.dart';

class HomeRepo {
  final _services = FirestoreService('task');

  Future<List<Task>> getTask() async {
    try {
      final result = await _services.getTask();
      return result.docs.map((e) {
        if (e.exists) return Task.fromJson(e.data());
      }).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Task>> fetchingPaginate(String orderBy, dynamic startItem,
      {int limitToLast = 10}) async {
    try {
      final result = await _services
          .collectionReference()
          .orderBy(orderBy)
          .startAfter(startItem)
          .limit(limitToLast)
          .get();

      var itemFixed = UnmodifiableListView(result.docs.map((e) {
        if (e.exists) {
          Task.fromJson(e.data());
        }
      }).toList());

      return itemFixed.toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> isDoneChecklist(Map data, String docName) async {
    try {
      await _services.updateTask(data, docName);
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteTask(String idDoc) async {
    await _services.deleteTask(idDoc);
    return;
  }

  String getId() => this._services.getId();
}
