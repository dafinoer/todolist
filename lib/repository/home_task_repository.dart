import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/api/firestore_service.dart';

class HomeTaskRepository {
  final _services = FirestoreService('task'); //HomeTaskService('task');

  Stream<QuerySnapshot> realTimeTask() =>
      _services.collectionReference().snapshots();

  Stream<QuerySnapshot> realTimeTaskDoc(String fieldName, String queryParam) =>
      _services
          .collectionReference()
          .where(fieldName, isEqualTo: queryParam)
          .snapshots();
}
