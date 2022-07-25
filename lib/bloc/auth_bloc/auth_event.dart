part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SigninEvent extends AuthEvent {
  final String email;
  final String password;
  SigninEvent(this.email, this.password);
}

class SignUpEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String password;
  SignUpEvent(this.fullName, this.email, this.password);
}

class LogoutEvent extends AuthEvent {}
