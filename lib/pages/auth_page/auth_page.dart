import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tik_dog/constants.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 34),
            Text(
              'Chose your App\nCheck your Star',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.225,
              ),
            ),
            const SizedBox(height: 16),
            // SvgPicture.asset('assets/icons/Steps.svg'),
            // Spacer(),
            Expanded(
              // width: double.infinity,
              child: Stack(
                children: [
                  SizedBox(width: double.infinity),
                  Positioned(
                    left: 0,
                    bottom: 190,
                    child: Image.asset('assets/images/InstagramLogo.png'),
                  ),
                  Positioned(
                    top: 0,
                    right: MediaQuery.of(context).size.width * 0.5 - 45,
                    child: Image.asset('assets/images/Steps.png'),
                  ),
                  Positioned(
                    right: 26,
                    left: 26,
                    bottom: -130,
                    child: Image.asset('assets/images/RedTorchLogin.png'),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/InstagramSymbol.png',
                      width: 254,
                      height: 275,
                    ),
                  ),
                  Positioned(
                    right: -20,
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/TikTokSymbol.png',
                      width: 290,
                      height: 333,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset('assets/images/TikTokLogo.png'),
                  ),
                ],
              ),
            ),
            AuthButton(
              text: 'Continue with Instagram',
              iconSource: 'assets/icons/InstagramLogo.svg',
              // onPressed: () => debugPrint('PLACEHOLDER: Auth instagram'),
              onPressed: () {
                // AdaptiveTheme.of(context).setLight();
                selectedSymbol = 'assets/images/InstagramSymbol';
                context.go('/loading', extra: false);
              },
            ),
            const SizedBox(height: 24),
            AuthButton(
              text: 'Continue with TikTok',
              iconSource: 'assets/icons/TikTokLogo.svg',
              // onPressed: () => debugPrint('PLACEHOLDER: Auth tiktok'),
              onPressed: () {
                selectedSymbol = 'assets/images/TikTokSymbol';
                context.go('/loading', extra: true);
              },
            ),
            const SizedBox(height: 21),
          ],
        ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  final String text;
  final String iconSource;
  final Function() onPressed;
  const AuthButton({
    super.key,
    required this.text,
    required this.iconSource,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromRGBO(77, 77, 77, 1)),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(iconSource),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
