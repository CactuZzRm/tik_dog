import 'package:flutter/material.dart';

import '../auth_information_page/auth_information_page.dart';
import '../rating_page/rating_page.dart';

class FriendsPage extends StatelessWidget {
  FriendsPage({super.key});

  final List<String> friends = [''];

  @override
  Widget build(BuildContext context) {
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
                    UserRating(
                      name: 'elkandar',
                      desc: '587 adv, 10%',
                      rating: '\$547.2',
                      imageUrl: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                      descFontSize: 15,
                      ratingFontSize: 17,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 21),
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
