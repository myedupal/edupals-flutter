import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PointStreakDisplay extends StatelessWidget {
  const PointStreakDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    return Row(
      children: [
        const ImageAssetView(
          fileName: AppAssets.diamond,
        ).padding(const EdgeInsets.only(right: AppValues.double5)),
        Text(
          "${mainController.currentUser.value?.points ?? 0} PTS",
          style: MyTextStyle.xs.extraBold,
        ),
        const SizedBox(
          width: AppValues.double10,
        ),
        const ImageAssetView(
          fileName: AppAssets.fire,
        ).padding(const EdgeInsets.only(right: AppValues.double5)),
        Text(
          "${mainController.currentUser.value?.dailyStreak ?? 0} Streak",
          style: MyTextStyle.xs.extraBold,
        )
      ],
    )
        .padding(const EdgeInsets.symmetric(horizontal: AppValues.double5))
        .topBarWidgetCapsule(color: AppColors.white);
  }
}
