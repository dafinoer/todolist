import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/api/read_collection.dart';
import 'package:todolist/model/task.dart';

class ReadRepository {
  final readRepository = ReadCollection(collectionName: 'task');

  Future<List<Task>> fetchPagination(
      DocumentSnapshot documentSnapshot) async {
    try {
      final result = await readRepository.pagination(documentSnapshot);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Task>> limit(int limit) async {
    try {
      final dataResult = await readRepository.taskLimit(limit);
      return dataResult;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> isDoneChecklist(Map data, String docName) async {
    try {
      await readRepository.updateTask(data, docName);
      return;
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<void> editTask(Map data, String docName) async {
    try {
      await isDoneChecklist(data, docName);
      return;
    } catch (e) {
      throw Exception(e);
    }
  }
}
