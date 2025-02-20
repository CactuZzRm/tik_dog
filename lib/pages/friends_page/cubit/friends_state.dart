part of 'friends_cubit.dart';

@immutable
sealed class FriendsState {}

final class FriendsInitial extends FriendsState {}

final class FriendsCurrentState extends FriendsState {
  final List<UserModel> friends;

  FriendsCurrentState({required this.friends});
}
