part of 'auth_loading_cubit.dart';

@immutable
sealed class AuthLoadingState {}

final class AuthLoadingPageInitial extends AuthLoadingState {}

final class AuthLoadingPageWebLoginProcess extends AuthLoadingState {}

final class AuthLoadingSuccessLogin extends AuthLoadingState {}

final class AuthLoadingNotSuccessLogin extends AuthLoadingState {}

// final class AuthLoadingPageCallback extends AuthLoadingPageState {}

// final class AuthLoadingPageWait extends AuthLoadingPageState {}

// final class AuthLoadingPageSuccess extends AuthLoadingPageState {}

// final class AuthLoadingPageError extends AuthLoadingPageState {}
