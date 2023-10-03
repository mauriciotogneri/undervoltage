import 'package:flutter/material.dart';
import 'package:undervoltage/json/json_card.dart';
import 'package:undervoltage/services/palette.dart';

class FaceDownPile extends StatelessWidget {
  final List<JsonCard> cards;
  final double width;
  final VoidCallback? onPressed;

  const FaceDownPile({
    required this.cards,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          width: 0.5,
          color: Palette.grey,
        ),
      ),
      child: Container(
        width: width,
        height: width * 1.56,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: width / 15,
            color: Palette.white,
          ),
          color: Palette.grey,
        ),
        child: Material(
          color: Palette.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: onPressed,
          ),
        ),
      ),
    );
  }
}
