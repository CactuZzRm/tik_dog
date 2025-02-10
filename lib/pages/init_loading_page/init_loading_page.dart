import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InitLoadingPage extends StatelessWidget {
  const InitLoadingPage({super.key});

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
