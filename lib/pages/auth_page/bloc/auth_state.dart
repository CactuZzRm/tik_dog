part of 'auth_bloc.dart';

class AuthState {}

class AuthLoading extends AuthState {}

class AuthInitialState extends AuthState {}

class AuthCurrentState extends AuthState {
  AuthCurrentState copyWith() {
    return AuthCurrentState();
  }
}

class AuthAuthenticatedState extends AuthState {}

class AuthUnauthenticatedState extends AuthState {}
