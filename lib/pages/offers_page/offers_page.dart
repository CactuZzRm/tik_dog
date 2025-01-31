import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../constants.dart';
import '../../themes.dart';
import '../auth_views_page/auth_views_page.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const SizedBox(height: 22),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 16),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                    child: OfferTypeContainer(text: '✨New', index: 0)),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                    child: OfferTypeContainer(text: 'In progress', index: 1)),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 2;
                      });
                    },
                    child: OfferTypeContainer(text: 'Completed', index: 2)),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 3;
                      });
                    },
                    child: OfferTypeContainer(text: 'Completed', index: 3)),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 4;
                      });
                    },
                    child: OfferTypeContainer(text: 'Completed', index: 4)),
                const SizedBox(width: 16),
              ],
            ),
          ),
          const SizedBox(height: 28),
          OfferCard(
            text: 'This offer is just for you',
            price: '\$1000',
            image: 'assets/images/Offer.png',
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              useRootNavigator: true,
              builder: (context) => OfferSelectedBottomSheet(),
            ),
          ),
        ],
      ),
    );
  }
}

class OfferSelectedBottomSheet extends StatelessWidget {
  const OfferSelectedBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 7.0,
            sigmaY: 7.0,
            tileMode: TileMode.clamp,
          ),
          child: SizedBox(),
        ),
        if (AdaptiveTheme.of(context).mode.isDark)
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.6 - 80,
            left: 16,
            right: 24,
            child: Image.asset('assets/images/RedTorchSelectOffer.png'),
          ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.6, //TODO: Для темной темы отступы
          left: 31,
          right: AdaptiveTheme.of(context).mode.isDark ? 36 : 38,
          child: Align(
            alignment: Alignment.centerRight,
            child: Image.asset('${selectedSymbol}AcceptOfferTopImage.png'),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Theme.of(context).splashColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => context.pop(),
                      child: SvgPicture.asset(
                        'assets/icons/Cross.svg',
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 76),
                Spacer(), //TODO: Решить вопрос с отступами
                Text(
                  'This offer is just for you',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    height: 1.33,
                  ),
                ),
                SizedBox(height: 51),
                Text(
                  '\$1000',
                  style: TextStyle(
                    color: Color.fromRGBO(42, 255, 173, 1),
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 51),
                Text(
                  'Will you accept this offer?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                Spacer(),

                GradientContainer(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ActionButton(
                    onPressed: () => context.pushNamed('AcceptOfferDetailsPage'),
                    text: 'Accept',
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(height: 16),
                ActionButton(
                  onPressed: () => context.pushNamed('DeniedOfferDetailsPage'),
                  text: 'Not now',
                  backgroundColor: Theme.of(context).cardColor,
                  margin: const EdgeInsets.symmetric(horizontal: 17),
                ),
                const SizedBox(height: 21),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.6 - 81 / 2 - MediaQuery.of(context).padding.top,
          left: MediaQuery.of(context).size.width / 2 - 81 / 2,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).hintColor,
            ),
            child: Text('🥳', style: TextStyle(fontSize: 40)),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.6 - 50 / 2 - MediaQuery.of(context).padding.top,
          left: MediaQuery.of(context).size.width / 2 - 50 / 2 - 80,
          child: Image.asset(
            '${selectedSymbol}LogoRightNotFilter.png',
          ),
        ),
      ],
    );
  }
}

class OfferTypeContainer extends StatelessWidget {
  final String text;
  final int index;

  const OfferTypeContainer({
    super.key,
    required this.text,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      needBackground: currentIndex == index,
      decoration: BoxDecoration(
        border: index != currentIndex
            ? Border.all(color: Theme.of(context).extension<CustomThemeData>()!.offersPageCategoryBorderColor!)
            : Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: currentIndex == index
              ? Colors.white
              : Theme.of(context).extension<CustomThemeData>()!.offersPageHeaderUnselectedCategoryColor!,
        ),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  final String image;
  final String text;
  final String price;
  final Function() onTap;

  const OfferCard({
    super.key,
    required this.image,
    required this.text,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(image, width: double.infinity, fit: BoxFit.cover),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).highlightColor,
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: Text(
                      price,
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(42, 255, 173, 1),
                        fontWeight: FontWeight.bold,
                        height: 1.21,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1.33,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
