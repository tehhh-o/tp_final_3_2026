import 'package:flutter/material.dart';

class AnimatedPriceText extends StatelessWidget {
  final double value;
  final TextStyle? style;

  const AnimatedPriceText({super.key, required this.value, this.style});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: value),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      builder: (context, val, _) {
        return Text('RM ${val.toStringAsFixed(2)}', style: style);
      },
    );
  }
}
