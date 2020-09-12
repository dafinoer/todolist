import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/api/firestore_dao.dart';

class ReadService {

  FirestoreDao _firestoreDao;
  
  ReadService(FirestoreDao dao){
    this._firestoreDao = dao;
  }

  Future<void> updateTask(Map data, String docName) async {
    try {
      await _firestoreDao.reference.doc(docName).update(data);
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<QuerySnapshot> realtimeState() => _firestoreDao.reference.snapshots();

  Stream<QuerySnapshot> realTimeQuery(String fieldName, String paramContain) =>
      _firestoreDao.reference.where(fieldName, isEqualTo: paramContain).snapshots();

  CollectionReference getCollection() => this._firestoreDao.reference;
}
