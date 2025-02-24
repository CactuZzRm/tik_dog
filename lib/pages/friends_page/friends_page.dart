import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_dog/pages/friends_page/cubit/friends_cubit.dart';

import '../../data/api/models/user_model.dart';
import '../auth_information_page/auth_information_page.dart';
import '../auth_loading_page/auth_loading_page.dart';
import '../error_page/error_page.dart';
import '../rating_page/rating_page.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsCubit, FriendsState>(
      builder: (context, state) {
        if (state is FriendsInitial) {
          context.read<FriendsCubit>().fetchFriends();
          return const Center(child: Center(child: AnimatedHorizontalSteps()));
        } else if (state is FriendsCurrentState) {
          final friends = state.friends;
          final model = context.read<FriendsCubit>();

          return friends.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 11),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17),
                      child: InviteFriendsDescription(),
                    ),
                    const SizedBox(height: 34),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: friends.length,
                        itemBuilder: (context, index) => FriendCard(
                          user: friends[index],
                          // desc: '587 adv, 10%',
                          descFontSize: 15,
                          ratingFontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    GradientContainer(
                      margin: const EdgeInsets.symmetric(horizontal: 17),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ActionButton(
                        onPressed: () => debugPrint('PLACEHOLDER: Click'),
                        text: 'Invite a friend',
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 21),
                  ],
                )
              : Column(
                  children: [
                    const Spacer(),
                    Text(
                      'Invite friends',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            height: 1.23,
                          ),
                    ),
                    const SizedBox(height: 22),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 39),
                      child: InviteFriendsDescription(textAlign: TextAlign.center),
                    ),
                    const SizedBox(height: 68),
                    const Spacer(),
                    GradientContainer(
                      margin: const EdgeInsets.symmetric(horizontal: 17),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ActionButton(
                        onPressed: () async {
                          await model.getShareFriendLink();
                        },
                        text: 'Invite a friend',
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 21),
                  ],
                );
        } else {
          return const ErrorPage();
        }
      },
    );
  }
}

class FriendCard extends StatelessWidget {
  final UserModel user;
  final String? desc;
  final int? rating;
  final double? descFontSize;
  double? ratingFontSize;

  FriendCard({
    super.key,
    required this.user,
    this.desc,
    this.rating,
    this.descFontSize,
    this.ratingFontSize,
  });

  String ratingFormatter(int rating) {
    if (rating >= 3) {
      ratingFontSize = 17;
      return '#$rating';
    } else if (rating == 0) {
      return '🥇';
    } else if (rating == 1) {
      return '🥈';
    } else if (rating == 2) {
      return '🥉';
    }

    return '';
  }

  String calculateRating(UserModel user) {
    final double count =
        (user.numberOfLikes + user.numberOfComments + user.numberOfShares) * 100 / user.numberOfMediaViews;

    return count > 0 ? count.toStringAsFixed(5) : '0.0';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 17, right: 12, bottom: 20),
      child: Row(
        children: [
          SizedBox(
            height: 44,
            width: 44,
            child: ClipOval(
              child: user.avatar != null
                  ? Image.network(
                      user.avatar!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Text('error'));
                      },
                    )
                  : DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(43, 43, 43, 1),
                      ),
                      child: Center(
                        child: Text(
                          user.name[0] + user.name[1],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                desc ?? calculateRating(user),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: descFontSize ?? 15,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(122, 122, 122, 1),
                    ),
              ),
            ],
          ),
          const Spacer(),
          rating != null
              ? Text(
                  ratingFormatter(rating!),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: ratingFontSize ?? 32,
                        fontWeight: FontWeight.bold,
                      ),
                )
              : const SizedBox(),
          SizedBox(width: rating != null && rating! >= 3 ? 8 : 0),
        ],
      ),
    );
  }
}

class InviteFriendsDescription extends StatelessWidget {
  final TextAlign textAlign;
  const InviteFriendsDescription({
    super.key,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textDirection: TextDirection.ltr,
      textAlign: textAlign,
      text: TextSpan(
        text: 'and get ',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.28,
          color: Theme.of(context).textTheme.bodyMedium!.color,
        ),
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GradientContainer(
              padding: const EdgeInsets.only(
                top: 7,
                right: 8,
                bottom: 8,
                left: 9,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
              ),
              child: Text(
                '10%',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.28,
                    ),
              ),
            ),
          ),
          const TextSpan(
            text: ' from advertising contract your friend secures',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.28,
            ),
          ),
        ],
      ),
    );
  }
}
