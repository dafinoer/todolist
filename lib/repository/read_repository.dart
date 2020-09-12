import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/api/read_service.dart';

class ReadRepository {
  ReadService _readService;

  ReadRepository(ReadService ref) {
    this._readService = ref;
  }

  Stream<QuerySnapshot> realTimeTask() => _readService.realtimeState();

  Stream<QuerySnapshot> realTimeTaskDoc(String fieldName, String queryParam) =>
      _readService.realTimeQuery(fieldName, queryParam);

  Future<void> isDoneChecklist(Map data, String docName) async {
    try {
      await _readService.updateTask(data, docName);
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
