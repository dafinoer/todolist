import 'package:cloud_firestore/cloud_firestore.dart';

class TaskCollection {
  CollectionReference _collectionReference;

  TaskCollection() {
    _collectionReference = FirebaseFirestore.instance.collection('task');
  }

  Future<void> addTask(Map<String, dynamic> data) async {
    try {
      await _collectionReference.add(data);
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateTask(Map data, String docName) async {
    try {
      await _collectionReference.doc(docName).update(data);
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteTask(String docId) async {
    await _collectionReference.doc(docId).delete();
    return;
  }
}