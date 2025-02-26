part of 'auth_loading_cubit.dart';

@immutable
sealed class AuthLoadingPageState {}

final class AuthLoadingPageInitial extends AuthLoadingPageState {}

final class AuthLoadingPageCallback extends AuthLoadingPageState {}

final class AuthLoadingPageWait extends AuthLoadingPageState {}
