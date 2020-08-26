

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/navigator/navigator_event.dart';
import 'package:todolist/bloc/navigator/navigator_state.dart';

class NavigatorBloc extends Bloc<NavigationType, NavigatorIndexState>{
  NavigatorBloc(NavigatorIndexState initialState) : super(initialState);

  @override
  Stream<NavigatorIndexState> mapEventToState(NavigationType event) async* {
    if(event == NavigationType.HOME){
      yield NavigatorIndexState(0);
    } else {
      yield NavigatorIndexState(1);
    }
  }
  
}