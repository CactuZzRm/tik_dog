import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:go_router/go_router.dart';

class AuthLoadingPage extends StatefulWidget {
  final bool isTikTok;
  const AuthLoadingPage({required this.isTikTok, super.key});

  @override
  State<AuthLoadingPage> createState() => _AuthLoadingPageState();
}

class _AuthLoadingPageState extends State<AuthLoadingPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      !widget.isTikTok ? AdaptiveTheme.of(context).setLight() : () {};
      context.replaceNamed('AuthStatisticPage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 40,
            // left: 204 / 2 - 93 - 93,
            child: Image.asset('assets/images/BlueTorchFull.png'),
          ),
          Positioned(
            bottom: -6,
            // left: -5,
            width: 205,
            height: 221,
            child: Image.asset('assets/images/LoadingPageInstaSymbol.png'),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset('assets/images/LoadingPageTikTokSymbol.png'),
          ),
          Positioned(
            bottom: 266,
            right: 2,
            child: Image.asset('assets/images/LoadingPageInstaLogo.png'),
          ),
          Positioned(
            bottom: 247,
            left: 15,
            child: Image.asset('assets/images/LoadingPageTikTokLogo.png'),
          ),
          Column(
            children: [
              const SizedBox(height: 69),
              Image.asset('assets/images/Steps.png'),
              const SizedBox(height: 68),
              Padding(
                padding: const EdgeInsets.only(left: 45, right: 35),
                child: Text(
                  'Give us time, we’re working through your incredible stats!!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      height: 1.58,
                      color: Theme.of(context).textTheme.bodyMedium!.color),
                ),
              ),
              const SizedBox(height: 66),
              Padding(
                padding: const EdgeInsets.only(left: 45, right: 35),
                child: FAProgressBar(
                  size: 11,
                  currentValue: 60,
                  borderRadius: BorderRadius.circular(31),
                  backgroundColor: Colors.white,
                  progressColor: Color.fromRGBO(255, 29, 101, 1),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
