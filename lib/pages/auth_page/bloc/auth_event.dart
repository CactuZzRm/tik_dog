part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthLoadingEvent extends AuthEvent {

}

class InitEvent extends AuthEvent {
  final String provider;

  InitEvent({required this.provider});
}

class AuthLoginEvent extends AuthEvent {
  final SocialNetworks socialNetwork;

  AuthLoginEvent({required this.socialNetwork});
}
