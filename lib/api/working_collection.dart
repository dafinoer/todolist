import 'package:cloud_firestore/cloud_firestore.dart';

class WorkingCollection {
  CollectionReference _reference;

  WorkingCollection() {
    _reference = FirebaseFirestore.instance.collection('working');
  }

  Future<void> addWorkingTask(Map<String, dynamic> data) async {
    try {
      await _reference.add(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
