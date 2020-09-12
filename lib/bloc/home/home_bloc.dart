import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/api/firestore_dao.dart';
import 'package:todolist/api/read_service.dart';
import 'package:todolist/api/task_service.dart';
import 'package:todolist/bloc/home/home_event.dart';
import 'package:todolist/bloc/home/home_state.dart';
import 'package:todolist/bloc/schedule/bloc.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/repository/read_repository.dart';
import 'package:todolist/repository/task_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _taskRepository = ReadRepository(ReadService(
      FirestoreDao(reference: FirebaseFirestore.instance.collection('task'))));

  final _deleteRepo = TaskRepository(TaskService(
      FirestoreDao(reference: FirebaseFirestore.instance.collection('task'))));

  final now = DateTime.now();

  StreamSubscription _subscription;

  ScheduleBloc _scheduleBloc;

  HomeBloc(HomeState initialState, ScheduleBloc scheduleBloc)
      : super(initialState) {
    _scheduleBloc = scheduleBloc;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    try {
      if (event is FirstOpen) {
        _subscription = _taskRepository.realTimeTask().listen((event) {
          final result =
              event.docs.map((e) => Task.fromJson(e.data(), e.id)).toList();
          add(ListEvent(itemTask: result));
          // _scheduleBloc.add(event);
          final task = result.firstWhere((task) =>
              task.schedule > now.millisecondsSinceEpoch && task.isChecked);
          print(task);
          _scheduleBloc.add(ScheduleTaskEvent(totalTask: result.length));
        });
      }
      if (event is ListEvent) {
        yield HomeLists(event.itemTask, false);
      }

      if (event is TaskDoneEvent) {
        await _taskRepository.isDoneChecklist(
            Task.checkUpdate(event.isDone), event.docName);
      }

      if (event is DeleteTask) {
        await _deleteRepo.deleteTask(event.idDoc);
      }
    } catch (e) {
      yield HomeError(e.toString());
    }
  }
}
