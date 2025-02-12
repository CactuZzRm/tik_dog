import 'package:flutter/material.dart';

import '../../themes.dart';

class RatingPage extends StatelessWidget {
  RatingPage({super.key});

  final List<String> creators = ['1'];

  @override
  Widget build(BuildContext context) {
    return creators.isNotEmpty
        ? Column(
            children: [
              SizedBox(height: 23),
              ProfileRating(
                desc: '123 456 789',
                rating: '#1234',
              ),
              const SizedBox(height: 34),
              TopRatingTitle(),
              const SizedBox(height: 26),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    UserRating(
                      name: 'elkandar',
                      desc: '123 456 789',
                      rating: '🥇',
                      descFontSize: 13,
                      imageUrl: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                    ),
                  ],
                ),
              )
            ],
          )
        : EmptyCreators();
  }
}

class UserRating extends StatelessWidget {
  final String name;
  final String desc;
  final String rating;
  final String? imageUrl;
  final double? descFontSize;
  final double? ratingFontSize;

  const UserRating({
    super.key,
    required this.name,
    required this.desc,
    required this.rating,
    this.imageUrl,
    this.descFontSize,
    this.ratingFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 17, right: 12),
      child: Row(
        children: [
          SizedBox(
            height: 44,
            width: 44,
            child: ClipOval(
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Text('error');
                      },
                    )
                  : DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(43, 43, 43, 1),
                      ),
                      child: Center(
                        child: Text(
                          name[0] + name[1],
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Text(
                  desc,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: descFontSize ?? 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(122, 122, 122, 1),
                      ),
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            rating,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: ratingFontSize ?? 32,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

class TopRatingTitle extends StatelessWidget {
  const TopRatingTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '14.4M creators',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  height: 1.28,
                ),
          ),
          Text(
            'Updating 1 time a day',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  height: 1.28,
                ),
          ),
        ],
      ),
    );
  }
}

class ProfileRating extends StatelessWidget {
  final String desc; //TODO: Изменить название на корректное
  final String rating;
  final String? imageUrl;

  const ProfileRating({
    super.key,
    required this.desc,
    required this.rating,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 16, right: 18),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).extension<CustomThemeData>()!.ratingProfileCardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 44,
            width: 44,
            child: ClipOval(
              child: imageUrl != null
                  ? Image.network(imageUrl!, fit: BoxFit.cover)
                  : DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(43, 43, 43, 1),
                      ),
                      child: Center(
                        child: Text(
                          'You',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                desc,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                    ),
              ),
            ],
          ),
          Spacer(),
          Text(
            rating,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}

class EmptyCreators extends StatelessWidget {
  const EmptyCreators({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Ждите обновления участников 1 марта',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              height: 1.28,
            ),
      ),
    );
  }
}
