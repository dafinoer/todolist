import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/add/add_event.dart';
import 'package:todolist/bloc/add/add_state.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/repository/read_repository.dart';
import 'package:todolist/repository/task_repository.dart';
import 'package:todolist/repository/working_repository.dart';
import 'package:todolist/utils/firebase_auth_singleton.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final bool isEdit;

  final TaskRepository _taskRepository = TaskRepository();

  final ReadRepository _readRepository = ReadRepository('task');

  final currentUser = FirebaseAuthSingleton.singleton();

  AddBloc(AddState initialState, {this.isEdit = false}) : super(initialState);

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  Stream<AddState> mapEventToState(AddEvent event) async* {
    final currentState = state;

    try {
      switch (event.runtimeType) {
        case TextEvent:
          yield* _textStream(currentState, event);
          break;

        case TypeChoice:
          yield* _typeChoice(currentState, event);
          break;

        case DateEvent:
          yield* _dataEvent(currentState, event);
          break;

        case SubmitEvent:
          yield* _onSubmit(currentState);
          break;

        case NotifStatusEvent:
          yield* _onNotifCheck(currentState, event);
          break;

        case SubmitEdit:
          final dataEvent = event as SubmitEdit;

          yield* _onSubmit(currentState, docName: dataEvent.idDoc);
          break;

        default:
      }
    } catch (e) {
      yield AddError(e.toString());
    }
  }

  bool isTodoState(AddState state) => state is TodoState;

  Stream<AddState> _textStream(AddState addState, TextEvent event) async* {
    if (addState is TodoState) {
      yield addState.copyWith(title: event.text);
    } else {
      yield TodoState(title: event.text);
    }
  }

  Stream<AddState> _typeChoice(TodoState addState, TypeChoice event) async* {
    yield isTodoState(state)
        ? addState.copyWith(type: event.txtType)
        : TodoState(type: event.txtType);
  }

  Stream<AddState> _dataEvent(TodoState addState, DateEvent event) async* {
    final dateTask = DateTime(event.dateTime.year, event.dateTime.month,
        event.dateTime.day, event.dayOfTime.hour, event.dayOfTime.minute);
    yield isTodoState(state)
        ? addState.copyWith(dateTime: dateTask)
        : TodoState(dateTime: event.dateTime);
  }

  Stream<AddState> _onNotifCheck(
      TodoState addstate, NotifStatusEvent event) async* {
    yield isTodoState(state)
        ? addstate.copyWith(isNotif: event.isChecked)
        : TodoState(isNotif: event.isChecked);
  }

  Stream<AddState> _onSubmit(TodoState newState, {String docName}) async* {
    if (newState.title != null &&
        newState.type != null &&
        newState.dateTime != null) {
      yield newState.copyWith(isLoading: true);

      final task = Task(
          title: newState.title,
          schedule: newState.dateTime.millisecondsSinceEpoch,
          emailUser: currentUser.auth.currentUser.email,
          username: currentUser.auth.currentUser.displayName,
          isChecked: newState.isChecked,
          isNotif: newState.isNotif,
          typeTask: newState.type.toLowerCase());

      if (!isEdit) {
        await _taskRepository.addNewTask(task);
      } else {
        final taskMap = task.toMap();
        taskMap.removeWhere((key, value) => key == 'doc_id');

        await _readRepository.editTask(taskMap, docName);
      }

      yield newState.copyWith(isLoading: false);
      yield SubmitLoading(true);
    }
  }
}
