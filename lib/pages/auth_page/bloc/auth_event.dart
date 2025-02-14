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

class SocialNetworkChangeEvent extends AuthEvent {
  final BuildContext themeContext;
  final bool isTikTok;

  SocialNetworkChangeEvent({required this.themeContext, required this.isTikTok});
}

class GetKeyEvent extends AuthEvent {}

class SetKeyEvent extends AuthEvent {
  final String key;

  SetKeyEvent({required this.key});
}
