import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/splash/presentation/controller/splash_controller.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends GetResponsiveView<SplashController> {
  DashboardView({super.key}) : super(alwaysUseBuilder: false);

  Widget get _challengeBanner => Container(
        margin: const EdgeInsets.all(AppValues.double20),
        padding: const EdgeInsets.all(AppValues.double20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AppAssets.dashboardChallengeBg))),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: AppValues.double20,
                ),
                Text(
                  "Daily Challenge",
                  style: MyTextStyle.h1.c(AppColors.white),
                ),
                Row(
                  children: [
                    Text(
                      "10 questions",
                      style: MyTextStyle.subtitle1.c(AppColors.white),
                    ),
                    Text(
                      "+10 exp ${screen.screenType.toString()}",
                      style: MyTextStyle.subtitle1.c(AppColors.white),
                    ).padding(const EdgeInsets.only(left: AppValues.double20))
                  ],
                ),
                const SizedBox(
                  height: AppValues.double20,
                ),
              ],
            ),
          ],
        ),
      );

  @override
  Widget builder() => Column(
        children: [_challengeBanner],
      ).scaffoldWrapper();
}
