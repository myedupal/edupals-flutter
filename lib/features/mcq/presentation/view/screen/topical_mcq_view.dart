import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/context_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopicalMcqView extends StatelessWidget {
  const TopicalMcqView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        SizedBox(
          height: AppValues.double100,
        ),
        ImageAssetView(
          fileName: AppAssets.comingSoonLottie,
          width: Get.dynamicWidth * 0.3,
        ),
        Text(
          "Something awesome is coming soon...",
          style: MyTextStyle.l.bold,
        )
      ],
    ));
  }
}