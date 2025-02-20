import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_dog/pages/auth_loading_page/auth_loading_page.dart';
import 'package:tik_dog/pages/wallet_page/bloc/wallet_bloc.dart';

import '../../data/api/models/user_model.dart';
import '../../themes.dart';
import 'cubit/rating_cubit.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingCubit, RatingState>(
      builder: (context, state) {
        if (state is RatingLoadingState) {
          context.read<RatingCubit>().fetchRating();
          return const Center(child: AnimatedHorizontalSteps());
        } else if (state is RatingCurrentState) {
          return state.rating.isNotEmpty
              ? Column(
                  children: [
                    const SizedBox(height: 23),
                    const ProfileRating(),
                    const SizedBox(height: 34),
                    const TopRatingTitle(),
                    const SizedBox(height: 26),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: state.rating.length,
                        itemBuilder: (context, index) => UserRating(
                          user: state.rating[index],
                          rating: index,
                          descFontSize: 13,
                        ),
                      ),
                    ),
                  ],
                )
              : const EmptyCreators();
        } else {
          return const Center(child: Text('error'));
        }
      },
    );
  }
}

class UserRating extends StatelessWidget {
  final UserModel user;
  final String? desc;
  final int? rating;
  final double? descFontSize;
  double? ratingFontSize;

  UserRating({
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
                        return const Text('error');
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
            '(likes+comm+shares)*100/views',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
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
  const ProfileRating({super.key});

  String calculateRating(UserModel user) {
    final double count =
        (user.numberOfLikes + user.numberOfComments + user.numberOfShares) * 100 / user.numberOfMediaViews;

    return count > 0 ? count.toStringAsFixed(5) : '0.0';
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<WalletBloc>();

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
              child: model.user.avatar != null && model.user.avatar != ''
                  ? Image.network(model.user.avatar!, fit: BoxFit.cover)
                  : DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(43, 43, 43, 1),
                      ),
                      child: Center(
                        child: Text(
                          model.user.name[0] + model.user.name[1],
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
              const SizedBox(height: 4),
              Text(
                calculateRating(model.user),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                    ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '#${model.user.rank}',
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Text(
          'Wait for the participants to be updated on March 1st',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                height: 1.28,
              ),
        ),
      ),
    );
  }
}
