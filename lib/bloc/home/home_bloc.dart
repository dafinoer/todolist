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
        yield HomeLists(itemTask, false);
      }

      if (event is ListEvent && !_isHasMax(current)) {
        if (current is HomeLists) {
          final lastItem = current.items.last;
          final itemResult = await homeRepo.fetchingPaginate('id', lastItem.id);

          if (itemResult.isNotEmpty) {
            yield current.copyWith(
                newitem: current.items + itemResult, isMax: false);
          } else {
            yield current.copyWith(isMax: true);
          }
        }
      }

      if (event is TaskDoneEvent) {
        await homeRepo.isDoneChecklist(
            Task.checkUpdate(event.isDone), event.docName);
      }

      if (event is DeleteTask) {
        if(current is HomeLists){
          await homeRepo.deleteTask(event.task.docId);
          current.items.remove(event.task);
          
          yield current.copyWith(newitem: List<Task>.from(current.items));
        }
      }
    } catch (e) {
      print(e);
      yield HomeError(e.toString());
    }
  }

  bool _isHasMax(HomeState stateitem) =>
      stateitem is HomeLists && stateitem.isMax;
}
