import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/add/add_event.dart';
import 'package:todolist/bloc/add/add_state.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/repository/task_repository.dart';
import 'package:todolist/repository/working_repository.dart';
import 'package:todolist/utils/firebase_auth_singleton.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  AddBloc(AddState initialState) : super(initialState);

  final WorkingRepository _repository = WorkingRepository();

  final TaskRepository _taskRepository = TaskRepository();

  final currentUser = FirebaseAuthSingleton.singleton();

  @override
  Future<void> close() {
    print('close');
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
    yield isTodoState(state)
        ? addState.copyWith(dateTime: event.dateTime)
        : TodoState(dateTime: event.dateTime);
  }

  Stream<AddState> _onSubmit(TodoState newState) async* {
    if (newState.title != null &&
        newState.type != null &&
        newState.dateTime != null) {
      yield newState.copyWith(isLoading: true);

      final task = Task(
          title: newState.title,
          schedule: newState.dateTime.millisecondsSinceEpoch,
          emailUser: currentUser.auth.currentUser.email,
          username: currentUser.auth.currentUser.displayName,
          typeTask: newState.type.toLowerCase());
      // await _repository.add(task);

      await _taskRepository.addNewTask(task);

      yield newState.copyWith(isLoading: false);
      yield SubmitLoading(true);
    }
  }
}
