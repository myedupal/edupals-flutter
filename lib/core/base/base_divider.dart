import 'package:edupals/core/values/app_colors.dart';
import 'package:flutter/material.dart';

class BaseDivider extends StatelessWidget {
  const BaseDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.gray200,
    );
  }
}
