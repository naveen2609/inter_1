part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthSignUpEvent extends AuthEvent {
  final String email, password, username;

  AuthSignUpEvent(this.email, this.password, this.username);
}

class AuthLogInEvent extends AuthEvent {
  final String email, password;

  AuthLogInEvent(this.email, this.password);
}

class AuthStateChangedEvent extends AuthEvent {
  final User? user;

  AuthStateChangedEvent(this.user);
}
