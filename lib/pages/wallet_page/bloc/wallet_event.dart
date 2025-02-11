part of 'wallet_bloc.dart';

@immutable
sealed class WalletEvent {}

class WalletInitEvent extends WalletEvent {
  final UserModel userModel;

  WalletInitEvent({required this.userModel});
}
