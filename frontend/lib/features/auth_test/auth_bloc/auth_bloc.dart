import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth_test/data/auth_service.dart';

import 'auth_event.dart';
import 'auth_state.dart';

extension AuthBlocExt on BuildContext {
  AuthBloc get authBloc => read<AuthBloc>();
  AuthState get authBlocState => authBloc.state;

  void addAuthEvent(AuthEvent event) {
    authBloc.add(event);
  }

  void init() {
    addAuthEvent(InitEvent());
  }
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  AuthBloc({required this.authService}) : super(AuthState()) {
    on<InitEvent>(_init);

    void _sendOtpRequested(event, emit) async {
      emit(AuthLoading());
      try {
        await authService.sendOtp(event.phoneNumber);
        emit(OtpSent());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    }

    void _verifyOtpRequested(event, emit) async {
      emit(AuthLoading());
      try {
        await authService.verifyOtp(event.otp);
        emit(Authenticated());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    }

    void _loggedOutRequested(event, emit) async {
      await authService.signOut();
      emit(Unauthenticated());
    }

    on<SendOtpRequested>(_sendOtpRequested);
    on<VerifyOtpRequested>(_verifyOtpRequested);
    on<LoggedOutRequested>(_loggedOutRequested);
  }

  void _init(InitEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final isLoggedIn = await authService.isLoggedIn();
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }
}
