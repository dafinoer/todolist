import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/api/task_collection.dart';
import 'package:todolist/model/task.dart';

class ReadCollection extends TaskCollection{
  CollectionReference _collectionReference;

  ReadCollection({@required String collectionName}) {
    _collectionReference =
        FirebaseFirestore.instance.collection(collectionName);
  }

  Stream<QuerySnapshot> realtimeState() => _collectionReference.snapshots();

  Future<List<Task>> pagination(
      DocumentSnapshot snapshotData) async {
    try {
      final result = await _collectionReference
          .startAfterDocument(snapshotData)
          .limit(20)
          .get();
      return result.docs.map((e) => Task.fromJson(e.data(), e.id)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Task>> taskLimit(int limit) async {
    try {
      final result = await _collectionReference.limit(limit).get();
      return result.docs.map((e) => Task.fromJson(e.data(), e.id)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
