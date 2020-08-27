import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginOnLoading extends LoginState {
  final bool isLoading;

  const LoginOnLoading(this.isLoading);
}

class LoginOnError extends LoginState {
  final String errorTxt;
  const LoginOnError(this.errorTxt);

  @override
  List<Object> get props => [errorTxt];
}

class LoginSuccesState extends LoginState {
  final bool isAuthentication;
  const LoginSuccesState(this.isAuthentication);

  @override
  List<Object> get props => [isAuthentication];
}
