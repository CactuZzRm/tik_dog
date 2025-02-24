part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthLoadingEvent extends AuthEvent {}

class InitEvent extends AuthEvent {
  final String provider;

  InitEvent({required this.provider});
}

class AuthLoginEvent extends AuthEvent {
  final SocialNetworks socialNetwork;
  final BuildContext themeContext;

  AuthLoginEvent({required this.socialNetwork, required this.themeContext});
}

class GetKeyEvent extends AuthEvent {}

class SetKeyEvent extends AuthEvent {
  final String key;

  SetKeyEvent({required this.key});
}
