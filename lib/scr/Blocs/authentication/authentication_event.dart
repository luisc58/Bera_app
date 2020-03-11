part of 'authentication_bloc.dart';

// states
// AppStarted
// LoggedIn
// LoggedOut
//|||||||||||||||||||||||

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends AuthenticationEvent {}