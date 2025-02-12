import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_dog/pages/friends_page/cubit/friends_cubit.dart';

import '../auth_information_page/auth_information_page.dart';
import '../rating_page/rating_page.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsCubit, FriendsState>(
      builder: (context, state) {
        if (state is FriendsInitial) {
          context.read<FriendsCubit>().fetchFriends();

          return Center(child: Text('loading'));
        } else if (state is FriendsCurrentState) {
          final friends = state.friends;

          return friends.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 11),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: InviteFriendsDescription(),
                    ),
                    SizedBox(height: 34),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(0),
                        children: [
                          for (int i = 0; i < friends.length; i++) ...[
                            UserRating(
                              name: friends[i].name,
                              desc: '587 adv, 10%',
                              rating: '\$547.2',
                              imageUrl: friends[i].avatar,
                              descFontSize: 15,
                              ratingFontSize: 17,
                            ),
                            SizedBox(height: 20),
                          ]
                        ],
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
                    Spacer(),
                    Text(
                      'Invite friends',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            height: 1.23,
                          ),
                    ),
                    const SizedBox(height: 22),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 39),
                      child: InviteFriendsDescription(textAlign: TextAlign.center),
                    ),
                    SizedBox(height: 68),
                    Spacer(),
                  ],
                );
        } else {
          return Center(child: Text('error'));
        }
      },
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
        text: "and get ",
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
          TextSpan(
            text: " from advertising contract your friend secures",
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
