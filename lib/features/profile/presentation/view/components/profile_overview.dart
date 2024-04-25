import 'package:edupals/core/base/base_progress_indicator.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileOverview extends StatelessWidget {
  const ProfileOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const ImageAssetView(
              fileName:
                  "https://images.pexels.com/photos/264905/pexels-photo-264905.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
              fit: BoxFit.cover,
              width: AppValues.double70,
              height: AppValues.double70,
            ).clip().capsulise(
                radius: 100,
                padding: const EdgeInsets.all(AppValues.double4),
                color: AppColors.accent500),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: AppValues.double10),
              width: Get.width * 0.20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: Text(
                        "LV   50",
                        style: MyTextStyle.s.bold.c(AppColors.white),
                        textAlign: TextAlign.center,
                      )
                              .capsulise(
                                  radius: 10,
                                  color: AppColors.white10,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: AppValues.double18))
                              .padding(const EdgeInsets.only(
                                  right: AppValues.double6))),
                      Expanded(
                          child: Text(
                        "LV   50",
                        style: MyTextStyle.s.bold.c(AppColors.white),
                        textAlign: TextAlign.center,
                      ).capsulise(
                              radius: 10,
                              color: AppColors.white10,
                              padding:
                                  const EdgeInsets.all(AppValues.double18)))
                    ],
                  ).padding(const EdgeInsets.only(bottom: AppValues.double6)),
                  BaseProgressIndicator(
                      height: AppValues.double6,
                      color: AppColors.white,
                      backgoundColor: AppColors.white10,
                      fixedPercentage: 0.3)
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Badges Collected",
                  style: MyTextStyle.s.bold.c(AppColors.white),
                ),
                Text(
                  "100",
                  style: MyTextStyle.m.c(AppColors.white),
                )
              ],
            ).padding(const EdgeInsets.only(left: AppValues.double10)),
            const Spacer(),
            const ImageAssetView(
              fileName: AppAssets.badgeMockup,
              width: AppValues.double70,
              height: AppValues.double70,
            )
          ],
        ).capsulise(
            radius: 10,
            color: AppColors.accent200,
            padding: const EdgeInsets.symmetric(
                horizontal: AppValues.double10, vertical: AppValues.double15)),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Display Name",
                  style: MyTextStyle.xs.bold.c(AppColors.white),
                ),
                Text(
                  "Johnson",
                  style: MyTextStyle.s.c(AppColors.white),
                )
              ],
            )
          ],
        ).padding(const EdgeInsets.only(
            top: AppValues.double20, bottom: AppValues.double10))
      ],
    ).imageBackground();
  }
}
