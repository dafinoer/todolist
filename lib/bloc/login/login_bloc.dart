import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/login/login_event.dart';
import 'package:todolist/bloc/login/login_state.dart';
import 'package:todolist/repository/authentication.dart';
import 'package:todolist/utils/shared_pref.dart';

class LoginBloc extends Bloc<LoginOnSubmit, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState);

  final Authentification authentification = Authentification();

  final SharePref preference = SharePref.singleton();

  @override
  Stream<LoginState> mapEventToState(LoginOnSubmit event) async* {
    if (event is LoginOnSubmit) {
      try {
        yield LoginOnLoading(true);
        final googleAuth = await authentification.signGoogle();
        await preference.setEmail(googleAuth.user.email);
        yield LoginSuccesState(true);
      } catch (e) {
        print(e);
        yield LoginOnError(e.toString());
      }
    }
  }
}
