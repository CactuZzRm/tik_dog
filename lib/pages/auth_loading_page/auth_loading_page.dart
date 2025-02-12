import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthLoadingPage extends StatefulWidget {
  const AuthLoadingPage({super.key});

  @override
  State<AuthLoadingPage> createState() => _AuthLoadingPageState();
}

class _AuthLoadingPageState extends State<AuthLoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 2,
            top: 170,
            child: Image.asset(
              'assets/images/BlueTorchInitLoadingPage.png',
            ),
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
            right: -150,
            bottom: 0,
            child: Image.asset(
              'assets/images/TikTokSymbol.png',
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/StepsHorizontalInitLoadingPage.png',
                ),
              ),
              const SizedBox(height: 58),
              SvgPicture.asset('assets/icons/BIGpie.svg'),
            ],
          ),
        ],
      ),
    );
  }
}
