part of 'wallet_bloc.dart';

sealed class WalletEvent {}

class WalletInitEvent extends WalletEvent {
  final UserModel userModel;

  WalletInitEvent({required this.userModel});
}

class ChangeUserEvent extends WalletEvent {}
