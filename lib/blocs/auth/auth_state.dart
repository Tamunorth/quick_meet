abstract class AuthState {}

class InitialState extends AuthState {}

class LoadingState extends AuthState {}

class SuccessState extends AuthState {}

class LoggedOutState extends AuthState {}

class ErrorState extends AuthState {
  final String message;
  final String? code;
  ErrorState({required this.message, this.code});
}
