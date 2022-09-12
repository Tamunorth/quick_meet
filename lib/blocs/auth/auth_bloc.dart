import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_meet/services/auth_service.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialState()) {
    on<InitEvent>(_init);
    on<SignInEvent>(_signInWithGoogle);
    on<SignOutEvent>(_signOut);
  }

  final AuthService _authService = AuthService();

  void _init(InitEvent event, Emitter<AuthState> emit) async {
    emit(state);
  }

  Future<void> _signInWithGoogle(
      SignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());

      await _authService.signInWithGoogle();
      emit(SuccessState());
    } catch (e) {
      if (e is FirebaseAuthException) {
        emit(ErrorState(
            message: e.message ?? "Failed to sign In", code: e.code ?? ''));
      }

      emit(ErrorState(message: "Failed to sign In"));
    }
  }

  Future _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());

      await _authService.signOut();

      emit(SuccessState());
    } catch (e) {
      if (e is FirebaseAuthException) {
        emit(ErrorState(
            message: e.message ?? "Failed to sign Out", code: e.code ?? ''));
      }

      emit(ErrorState(message: "Failed to sign Out"));
    }
  }
}
