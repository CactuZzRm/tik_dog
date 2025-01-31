import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:tik_dog/constants.dart';

import '../auth_views_page/auth_views_page.dart';

class AuthStatisticPage extends StatelessWidget {
  const AuthStatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            if (AdaptiveTheme.of(context).mode.isDark)
              Positioned(
                bottom: 120,
                right: 0,
                child: Image.asset('assets/images/BlueTorch.png'),
              ),
            Positioned(
              bottom: 200,
              right: 0,
              child: Image.asset(AdaptiveTheme.of(context).mode.isDark
                  ? 'assets/images/DarkSteps.png'
                  : 'assets/images/LightSteps.png'),
            ),
            Positioned(
                bottom: 121,
                left: MediaQuery.of(context).size.width * 0.5 - 117,
                // child: Image.asset('assets/images/TikTokSymbolFull.png')),
                child: Image.asset('${selectedSymbol}Full.png')),
            Column(
              children: [
                const SizedBox(height: 26),
                StatisticContainer(title: 'Subscribers', value: '24 567'),
                const SizedBox(height: 4),
                StatisticContainer(title: 'Videos', value: '789'),
                const SizedBox(height: 4),
                StatisticContainer(title: 'Likes', value: '123 456'),
                const SizedBox(height: 45),
                StatisticDetails(),
                Spacer(),
                GradientContainer(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ActionButton(
                    onPressed: () {
                      // debugPrint('PLACEHOLDER: NEXT');
                      context.replaceNamed('AuthViewsPage');
                    },
                    text: 'Next',
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 18),
                ActionButton(
                  onPressed: () {
                    debugPrint('PLACEHOLDER: SHARE');
                  },
                  text: 'Share',
                  // backgroundColor: Colors.white.withOpacity(0.2),
                  backgroundColor: Theme.of(context).cardColor,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                ),
                const SizedBox(height: 8),
                Text(
                  'Wow! You have an amazing profile!',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 112,
              left: -40,
              child: Text('🔥', style: TextStyle(fontSize: 64)),
            ),
            Positioned(
              top: 152,
              right: 5,
              child: Text('🔥', style: TextStyle(fontSize: 32)),
            ),
            Positioned(
              top: 420,
              left: 20,
              child: Text('🔥', style: TextStyle(fontSize: 32)),
            ),
            Positioned(
              top: 420,
              right: 22,
              child: Text('🔥', style: TextStyle(fontSize: 20)),
            ),
            Positioned(bottom: 140, left: 0, child: Image.asset('${selectedSymbol}LogoReversed.png')),
          ],
        ),
      ),
    );
  }
}

class StatisticDetails extends StatelessWidget {
  const StatisticDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatisticCountContainer(
              text: 'of video',
              value: '870k',
              margin: const EdgeInsets.only(left: 35, bottom: 45),
            ),
            StatisticCountContainer(
              text: 'Views',
              value: '870k',
              margin: const EdgeInsets.only(right: 22, bottom: 45),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatisticCountContainer(
              text: 'Shared',
              value: '1.5k',
              margin: const EdgeInsets.only(left: 32, bottom: 45),
            ),
            StatisticCountContainer(
              text: 'Comments',
              value: '870k',
              margin: const EdgeInsets.only(
                top: 18,
                right: 28,
                bottom: 45,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class StatisticContainer extends StatelessWidget {
  final String title;
  final String value;
  const StatisticContainer({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 14,
        right: 17,
        bottom: 14,
        left: 21,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).hintColor,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class StatisticCountContainer extends StatelessWidget {
  const StatisticCountContainer({
    super.key,
    required this.text,
    required this.value,
    required this.margin,
  });
  final String text;
  final String value;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AdaptiveTheme.of(context).mode.isDark
              ? Stack(
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        color: Color.fromRGBO(4, 211, 237, 1),
                        fontSize: 53,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Color.fromRGBO(254, 44, 85, 1),
                          fontSize: 53,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              : GradientedText(text: value),
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class GradientedText extends StatelessWidget {
  const GradientedText({
    super.key,
    required this.text,
    this.textStyle,
  });

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GradientText(
      text,
      style: textStyle ??
          TextStyle(
            fontSize: 53,
            fontWeight: FontWeight.bold,
          ),
      colors: [
        Color.fromRGBO(108, 34, 193, 1),
        Color.fromRGBO(229, 36, 69, 1),
      ],
    );
  }
}

// class ActionButton extends StatelessWidget {
//   final Function() onPressed;
//   final String text;
//   final Color backgroundColor;

//   const ActionButton({
//     super.key,
//     required this.onPressed,
//     required this.text,
//     required this.backgroundColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.symmetric(horizontal: 15),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor,
//           padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
//           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 15,
//           ),
//         ),
//       ),
//     );
//   }
// }
