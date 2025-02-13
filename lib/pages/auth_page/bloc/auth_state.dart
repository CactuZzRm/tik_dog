part of 'auth_bloc.dart';

class AuthState {}

class AuthLoading extends AuthState {}

class AuthCurrentState extends AuthState {
  AuthCurrentState copyWith() {
    return AuthCurrentState();
  }
}
