part of 'wallet_bloc.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}

class WalletCurrentState extends WalletState {
  final UserModel user;

  WalletCurrentState({required this.user});
}
