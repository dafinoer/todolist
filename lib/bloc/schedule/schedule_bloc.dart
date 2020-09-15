import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/schedule/schedule_event.dart';
import 'package:todolist/bloc/schedule/schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final FirebaseMessaging _messaging = FirebaseMessaging();

  ScheduleBloc(ScheduleState initialState) : super(initialState){
    _messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    
    );
  }

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
