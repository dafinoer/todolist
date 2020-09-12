import 'package:todolist/api/firestore_dao.dart';

class TaskService {
  FirestoreDao _dao;

  TaskService(FirestoreDao daoparams) {
    this._dao = daoparams;
  }

  Future<void> addTask(Map<String, dynamic> data) async {
    try {
      await _dao.reference.add(data);
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateTask(Map data, String docName) async {
    try {
      await _dao.reference.doc(docName).update(data);
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteTask(String docId) async {
    await _dao.reference.doc(docId).delete();
    return;
  }
}