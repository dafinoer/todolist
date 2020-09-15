import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todolist/bloc/login/login_event.dart';
import 'package:todolist/bloc/login/login_state.dart';
import 'package:todolist/repository/authentication.dart';
import 'package:todolist/utils/shared_pref.dart';
import 'package:todolist/utils/strings.dart';

class LoginBloc extends Bloc<LoginOnSubmit, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState);
  
  final SharePref preference = SharePref.singleton();

  final storage = FlutterSecureStorage();

  @override
  Stream<LoginState> mapEventToState(LoginOnSubmit event) async* {
    if (event is LoginOnSubmit) {
      try {
        yield LoginOnLoading(true);
        final dataUser = await Authentification.signGoogle();
        await storage.write(key: Strings.token_user, value: dataUser.credential.token.toString());
        preference.setFirstApp(true);
        yield LoginSuccesState(true);
      } catch (e) {
        print(e);
        yield LoginOnError(e.toString());
      }
    }
  }
}
