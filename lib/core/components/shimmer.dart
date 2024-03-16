import 'package:card_loading/card_loading.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class Shimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final bool? hasOpacity;

  const Shimmer.rectangular({
    required this.height,
    required this.width,
    this.borderRadius = AppValues.double0,
    this.hasOpacity,
    super.key,
  });

  const Shimmer.circular({
    required this.height,
    this.width,
    this.borderRadius = AppValues.double50,
    this.hasOpacity,
    super.key,
  });

  const Shimmer.rounded({
    required this.height,
    required this.width,
    this.borderRadius = AppValues.double10,
    this.hasOpacity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CardLoading(
        height: height ?? 0,
        width: width ?? height,
        cardLoadingTheme: (hasOpacity ?? false)
            ? CardLoadingTheme(
                colorOne: AppColors.gray100.withAlpha(200),
                colorTwo: AppColors.gray100.withAlpha(200),
              )
            : CardLoadingTheme.defaultTheme,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
      ),
    );
  }
}
