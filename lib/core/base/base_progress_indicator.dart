import 'package:flutter/material.dart';

class BaseProgressIndicator extends StatelessWidget {
  const BaseProgressIndicator(
      {super.key,
      required this.color,
      required this.backgoundColor,
      required this.fixedPercentage,
      this.height});

  final Color color;
  final Color backgoundColor;
  final double fixedPercentage;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      tween: Tween<double>(
        begin: 0,
        end: fixedPercentage,
      ),
      builder: (context, value, _) => ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: LinearProgressIndicator(
            value: (value.isNaN || value.isInfinite) ? 0 : value,
            minHeight: height ?? 12,
            backgroundColor: backgoundColor,
            color: color,
            semanticsLabel: 'Linear progress indicator',
          )),
    );
  }
}
