abstract class MeetingState {}

class InitialState extends MeetingState {}

class LoadingState extends MeetingState {}

class SuccessState extends MeetingState {}

class ErrorState extends MeetingState {
  final String message;
  final String? code;
  ErrorState({required this.message, this.code});
}
