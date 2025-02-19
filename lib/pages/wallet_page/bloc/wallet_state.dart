part of 'wallet_bloc.dart';

sealed class WalletState {}

final class WalletLoadingState extends WalletState {}

final class WalletInitial extends WalletState {}

class WalletCurrentState extends WalletState {
  final UserModel user;

  WalletCurrentState({required this.user});
}
