import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/api/read_collection.dart';
import 'package:todolist/bloc/task/task_event.dart';
import 'package:todolist/bloc/task/task_state.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/repository/read_repository.dart';
import 'package:todolist/utils/strings.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  StreamSubscription _subscription;

  final ReadRepository _repository = ReadRepository(Strings.task.toLowerCase());

  final ReadCollection _collection =
      ReadCollection(collectionName: Strings.task.toLowerCase());

  final String queryField;

  TaskBloc(TaskState initialState, this.queryField) : super(initialState);

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    final current = state;
    try {
      if (event is FirstOpenTask) {
        if (current is TaskLoading) {
          _subscription = _repository
              .realTimeTaskDoc('type_task', queryField)
              .listen((event) {
            final result = _listOfTask(event);

            add(ListTask(result));
          });
        }
      }

      if (event is ListTask) {
        yield TaskLoaded(event.tasks);
      }
    } catch (e) {
      print(e.toString());
      yield TaskError(error: e.toString());
    }
  }

  List<Task> _listOfTask(QuerySnapshot event) =>
      event.docs.map((e) => Task.fromJson(e.data(), e.id)).toList();
}
