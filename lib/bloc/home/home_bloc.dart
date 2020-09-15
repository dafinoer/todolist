import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/home/home_event.dart';
import 'package:todolist/bloc/home/home_state.dart';
import 'package:todolist/bloc/schedule/bloc.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/repository/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final homeRepo = HomeRepo();

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
    final current = state;

    try {
      if (event is FirstOpen) {
        final itemTask = await homeRepo.getTask();

        itemTask.forEach((element) {
          print(element);
        });

        yield HomeLists(itemTask, false);
      }
      if (event is ListEvent) {
        yield HomeLists(event.itemTask, false);
      }

      if (event is TaskDoneEvent) {
        await homeRepo.isDoneChecklist(
            Task.checkUpdate(event.isDone), event.docName);
      }

      if (event is DeleteTask) {
        await homeRepo.deleteTask(event.idDoc);
      }
    } catch (e) {
      print(e);
      yield HomeError(e.toString());
    }
  }
}
