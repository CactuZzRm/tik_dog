import 'package:flutter/material.dart';

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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).highlightColor,
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: Text(
                      price,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
