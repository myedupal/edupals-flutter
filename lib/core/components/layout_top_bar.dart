import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class LayoutTopBar extends StatelessWidget {
  const LayoutTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [ImageAssetView(fileName: AppAssets.appIcon), Spacer()],
    ).capsulise(
        radius: 100,
        color: AppColors.gray100,
        padding: const EdgeInsets.all(AppValues.double10));
  }
}
