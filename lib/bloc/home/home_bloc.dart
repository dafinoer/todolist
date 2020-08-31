import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/home/home_event.dart';
import 'package:todolist/bloc/home/home_state.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/repository/read_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _taskRepository = ReadRepository();

  StreamSubscription _subscription;

  HomeBloc(HomeState initialState) : super(initialState);

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    final current = state;
    try {
      if(event is FirstOpen){
        _subscription = _taskRepository.readRepository.realtimeState().listen((event) {
          final result = event.docs.map((e) => Task.fromJson(e.data())).toList();
          add(ListEvent(itemTask: result));
        });
      }

      if(event is ListEvent){
        yield HomeLists(event.itemTask, false);
      }
    } catch (e) {
      yield HomeError(e.toString());
    }
  }
}
