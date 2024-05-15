import 'package:edupals/core/components/base_accordion.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/components/no_data_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/presentation/controller/daily_challenge_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyChallengeView extends GetView<DailyChallengeController> {
  const DailyChallengeView({super.key});

  Widget get challengeList => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ImageAssetView(
                fileName: AppAssets.backIcon,
                height: AppValues.double15,
                color: AppColors.gray900,
              )
                  .capsulise(
                      radius: 100,
                      color: AppColors.gray100,
                      padding: const EdgeInsets.all(AppValues.double15))
                  .padding(const EdgeInsets.only(right: AppValues.double10))
                  .onTap(() {
                Get.back();
              }),
              Text(
                "Subject List",
                style: MyTextStyle.xl.bold,
              ),
            ],
          ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
          Obx(() => Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.subjectList?.toList().length,
                  itemBuilder: (context, dataIndex) {
                    final subject = controller.subjectList?[dataIndex];
                    final filteredChallenge = controller.challengeList
                        ?.where((e) => e.subject?.name == subject);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseAccordion(
                            title: subject,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...?filteredChallenge?.map((e) => Row(
                                      children: [
                                        Text(
                                          "${e.title}",
                                          style: MyTextStyle.s,
                                        )
                                      ],
                                    )
                                        .capsulise(
                                            radius: 10,
                                            color: AppColors.gray100,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: AppValues.double20,
                                                horizontal: AppValues.double20))
                                        .padding(const EdgeInsets.only(
                                            bottom: AppValues.double10))
                                        .onTap(() {
                                      Get.toNamed(
                                          "${Routes.challengeDetails}/${e.id}");
                                    }))
                              ],
                            ))
                      ],
                    ).padding(const EdgeInsets.only(bottom: AppValues.double5));
                  })))
        ],
      ).padding(const EdgeInsets.all(AppValues.double20));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => controller.challengeList?.isEmpty == true
            ? const Expanded(
                child: NoDataView(
                    message: "There is no challenge for you today..."))
            : Expanded(child: challengeList))
      ],
    ).scaffoldWrapper();
  }
}
