import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  
  CollectionReference _reference;

  FirestoreService(String collectionName) {
    _reference = FirebaseFirestore.instance.collection(collectionName);
  }

  String getId() => this._reference.doc().id;

  Future<QuerySnapshot> getTask({int limit = 10}) async {
    final itemResult = await _reference.limit(limit).get();
    return itemResult;
  }

  Future<void> addTask(Map<String, dynamic> data) async {
    try {
      await _reference.add(data);
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteTask(String docId) async {
    await _reference.doc(docId).delete();
    return;
  }

  Future<void> updateTask(Map data, String docName) async {
    await _reference.doc(docName).update(data);
    return;
  }

  CollectionReference collectionReference() => this._reference;
}
