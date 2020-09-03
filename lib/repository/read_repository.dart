import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/api/read_collection.dart';
import 'package:todolist/model/task.dart';

class ReadRepository {
  ReadCollection _readRepository;

  ReadRepository(String typeName) {
    this._readRepository = ReadCollection(collectionName: typeName);
  }

  Stream<QuerySnapshot> realTimeTask() => _readRepository.realtimeState();

  Stream<QuerySnapshot> realTimeTaskDoc(String fieldName, String queryParam) =>
      _readRepository.realTimeQuery(fieldName, queryParam);

  Future<List<Task>> fetchPagination(DocumentSnapshot documentSnapshot) async {
    try {
      final result = await _readRepository.pagination(documentSnapshot);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Task>> limit(int limit) async {
    try {
      final dataResult = await _readRepository.taskLimit(limit);
      return dataResult;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> isDoneChecklist(Map data, String docName) async {
    try {
      await _readRepository.updateTask(data, docName);
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
