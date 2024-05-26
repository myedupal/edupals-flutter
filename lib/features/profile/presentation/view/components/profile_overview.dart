import 'package:edupals/core/base/base_progress_indicator.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/components/point_streak_display.dart';
import 'package:edupals/core/components/profile_picture.dart';
import 'package:edupals/core/extensions/context_extensions.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileOverview extends GetView<MainController> {
  const ProfileOverview({super.key});

  Widget get badgeDisplay => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Badges Collected",
                style: MyTextStyle.s.bold.c(AppColors.white),
              ),
              Text(
                "0",
                style: MyTextStyle.m.c(AppColors.white),
              )
            ],
          )
          // const ImageAssetView(
          //   fileName: AppAssets.badgeMockup,
          //   width: AppValues.double60,
          //   height: AppValues.double60,
          // )
        ],
      )
          .capsulise(
              radius: 10,
              color: AppColors.white10,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.double20, vertical: AppValues.double15))
          .padding(const EdgeInsets.symmetric(horizontal: AppValues.double10));

  Widget get pointDisplay => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "EDU\nPOINTS",
                style: MyTextStyle.xs.extraBold.c(AppColors.white),
              ),
            ],
          ),
          Obx(() => Text(
                "${controller.currentUser.value?.points ?? 0}",
                style: MyTextStyle.xl.bold.c(AppColors.white),
              ))
        ],
      )
          .capsulise(
              radius: 10,
              color: AppColors.white10,
              padding: const EdgeInsets.all(AppValues.double20))
          .padding(const EdgeInsets.symmetric(horizontal: AppValues.double10));

  Widget get levelingDisplay => Column(
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
                      .padding(
                          const EdgeInsets.only(right: AppValues.double6))),
              Expanded(
                  child: Text(
                "LV   50",
                style: MyTextStyle.s.bold.c(AppColors.white),
                textAlign: TextAlign.center,
              ).capsulise(
                      radius: 10,
                      color: AppColors.white10,
                      padding: const EdgeInsets.all(AppValues.double18)))
            ],
          ).padding(const EdgeInsets.only(bottom: AppValues.double6)),
          BaseProgressIndicator(
              height: AppValues.double6,
              color: AppColors.white,
              backgoundColor: AppColors.white10,
              fixedPercentage: 0.3)
        ],
      ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double10));

  Widget _infoDisplay({String? title, String? subtitle}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: MyTextStyle.xs.bold.c(AppColors.white),
        ),
        Text(
          subtitle ?? "",
          style: MyTextStyle.s.c(AppColors.white),
        )
      ],
    ).padding(const EdgeInsets.only(right: AppValues.double20));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const ProfilePicture(
              size: AppValues.double40,
            )
                .capsulise(
                    radius: 100,
                    padding: const EdgeInsets.all(AppValues.double4),
                    color: AppColors.accent500)
                .padding(const EdgeInsets.only(right: AppValues.double10)),
            // Flexible(
            //     flex: context.isPhonePortrait ? 0 : 5,
            //     child: pointDisplay.padding(EdgeInsets.only(
            //         bottom: context.isPhonePortrait ? AppValues.double10 : 0))),
            Expanded(
                flex: 5,
                child: PointStreakDisplay(
                  rowMainAlignment: MainAxisAlignment.spaceEvenly,
                  backgroundColor: AppColors.white10,
                  textColor: AppColors.white,
                ))
            // Flexible(flex: context.isPhonePortrait ? 0 : 5, child: badgeDisplay)
          ],
        ).capsulise(
            radius: 10,
            color: AppColors.accent200,
            padding: const EdgeInsets.symmetric(
                horizontal: AppValues.double10, vertical: AppValues.double15)),
        Obx(() => [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _infoDisplay(
                      subtitle: controller.currentUser.value?.name ?? "",
                      title: "Display Name"),
                  _infoDisplay(
                      subtitle:
                          controller.currentUser.value?.phoneNumber ?? "-",
                      title: "Phone Number"),
                ],
              ),
              const SizedBox(
                height: AppValues.double10,
              ),
              Row(
                children: [
                  _infoDisplay(
                      subtitle: controller.currentUser.value?.email ?? "-",
                      title: "Email Address")
                ],
              ),
            ]
                .rowToColumn(
                    isActive: context.isPhonePortrait,
                    rowMainAlignment: MainAxisAlignment.start)
                .padding(const EdgeInsets.only(
                    top: AppValues.double20, bottom: AppValues.double10)))
      ],
    ).imageBackground();
  }
}
