import 'dart:async';

import 'package:auvnet/features/auth/domain/usecases/get_auth_state_use_case.dart';
import 'package:auvnet/features/auth/domain/usecases/get_last_signed_in_use_case.dart';
import 'package:auvnet/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:auvnet/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:auvnet/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:auvnet/features/auth/presentation/bloc/auth_events.dart';
import 'package:auvnet/features/auth/presentation/bloc/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetAuthStateUseCase _getAuthStateUseCase;
  final GetLastSignedInUserUseCase _getLastSignedInUserUseCase;
  StreamSubscription<UserEntity?>? _authStateSubscription;

  AuthBloc({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required SignOutUseCase signOutUseCase,
    required GetAuthStateUseCase getAuthStateUseCase,
    required GetLastSignedInUserUseCase getLastSignedInUserUseCase,
  }) : _signInUseCase = signInUseCase,
       _signUpUseCase = signUpUseCase,
       _signOutUseCase = signOutUseCase,
       _getAuthStateUseCase = getAuthStateUseCase,
       _getLastSignedInUserUseCase = getLastSignedInUserUseCase,
       super(AuthInitial()) {
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<SignOutEvent>(_onSignOut);
    on<AuthStateChangedEvent>(_onAuthStateChanged);
    on<CheckLastSignedInUserEvent>(_onCheckLastSignedInUser);

    _authStateSubscription = _getAuthStateUseCase().listen(
      (user) => add(AuthStateChangedEvent(user)),
    );

    // Check for last signed in user when bloc is created
    add(CheckLastSignedInUserEvent());
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _signInUseCase(event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _signUpUseCase(event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _signOutUseCase();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(Unauthenticated()),
    );
  }

  void _onAuthStateChanged(
    AuthStateChangedEvent event,
    Emitter<AuthState> emit,
  ) {
    if (event.user != null) {
      emit(Authenticated(event.user!));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onCheckLastSignedInUser(
    CheckLastSignedInUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _getLastSignedInUserUseCase();
    result.fold((failure) => emit(AuthError(failure.message)), (user) {
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
