import 'package:meta/meta.dart';

class LoginState {
  final bool isSuccess;
  final bool isFailure;
  final bool isSubmitting;

  LoginState({
    @required this.isSuccess,
    @required this.isSubmitting,
    @required this.isFailure

  });

  factory LoginState.empty() {
    return LoginState(
      isSuccess: false,
      isSubmitting: false,
      isFailure: false
    );
  }

  factory LoginState.loading() {
    return LoginState(
        isSuccess: false,
        isSubmitting: true,
        isFailure: false
    );
  }

  factory LoginState.success() {
    return LoginState(
        isSuccess: true,
        isSubmitting: false,
        isFailure: false
    );
  }

  factory LoginState.failure() {
    return LoginState(
        isSuccess: false,
        isSubmitting: false,
        isFailure: true
    );
  }
}
