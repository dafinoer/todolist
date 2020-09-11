import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/schedule/schedule_event.dart';
import 'package:todolist/bloc/schedule/schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(ScheduleState initialState) : super(initialState);

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    final current = state;
    try {
      if (event is ScheduleTaskEvent) {
        if(current is ScheduleTask){
          yield current.copyWith(total: event.totalTask);
        }
      }
    } catch (e) {
      yield ScheduleError(e.toString());
    }
  }
}
