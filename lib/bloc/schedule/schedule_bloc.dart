import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/schedule/schedule_event.dart';
import 'package:todolist/bloc/schedule/schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(ScheduleState initialState) : super(initialState);

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    try {
      if (event is FirstOpenSchedule) {

      }
    } catch (e) {
      yield ScheduleError(e.toString());
    }
  }
}
