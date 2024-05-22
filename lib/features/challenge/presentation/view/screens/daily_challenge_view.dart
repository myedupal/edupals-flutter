import 'package:edupals/core/components/no_data_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/domain/model/challenge.dart';
import 'package:edupals/features/challenge/domain/model/challenge_argument.dart';
import 'package:edupals/features/challenge/presentation/controller/daily_challenge_controller.dart';
import 'package:edupals/features/challenge/presentation/view/components/challenge_card.dart';
import 'package:edupals/features/challenge/presentation/view/components/challenge_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyChallengeView extends GetView<DailyChallengeController> {
  const DailyChallengeView({super.key});

  Widget get challengeList => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ChallengeTopBar()
              .padding(const EdgeInsets.only(bottom: AppValues.double20)),
          Obx(() => Expanded(
                  child: GridView.builder(
                padding: const EdgeInsets.all(AppValues.double20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2,
                    crossAxisSpacing: AppValues.double10,
                    mainAxisSpacing: AppValues.double10),
                itemBuilder: (_, index) {
                  final Challenge? challenge = controller.challengeList?[index];
                  return ChallengeCard(
                    challenge: challenge,
                    onClick: () {
                      Get.toNamed(Routes.challengeDetails,
                          arguments: ChallengeArgument(
                              challengeId: challenge?.id,
                              title: "Daily Challenge"));
                    },
                  );
                },
                itemCount: controller.challengeList?.length,
              ))),
        ],
      ).padding(const EdgeInsets.all(AppValues.double20)).addBackgroundImage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => controller.challengeList?.isEmpty == true
            ? const NoDataView(
                message: "There is no challenge for you today...")
            : Expanded(child: challengeList))
      ],
    ).scaffoldWrapper();
  }
}
