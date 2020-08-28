import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/add/add_event.dart';
import 'package:todolist/bloc/add/add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  AddBloc(AddState initialState) : super(initialState);

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
          break;

        default:
      }
    } catch (e) {
      yield AddError(e);
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
    yield isTodoState(state) ?  addState.copyWith(type: event.txtType) : TodoState(type: event.txtType);
  }

  Stream<AddState> _dataEvent(TodoState addState, DateEvent event) async* {
    yield isTodoState(state)
        ? addState.copyWith(dateTime: event.dateTime)
        : TodoState(dateTime: event.dateTime);
  }
}
