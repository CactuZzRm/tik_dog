part of 'wallet_bloc.dart';

sealed class WalletEvent {}

class WalletInitEvent extends WalletEvent {
  final UserModel userModel;

  WalletInitEvent({required this.userModel});
}

class ChangeTokenEvent extends WalletEvent {
  final SocialNetworks socialNetwork;

  ChangeTokenEvent({required this.socialNetwork});
}

class GetUserData extends WalletEvent {
  final bool needChangeSocialNetwork;

  GetUserData({this.needChangeSocialNetwork = false});
}

class SaveUserId extends WalletEvent {}

class GroupUserById extends WalletEvent {}
