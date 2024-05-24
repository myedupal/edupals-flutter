import 'package:edupals/core/components/loading_view.dart';
import 'package:edupals/core/components/no_data_view.dart';
import 'package:edupals/core/enum/view_state.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/presentation/controller/daily_challenge_controller.dart';
import 'package:edupals/features/challenge/presentation/view/components/challenge_top_bar.dart';
import 'package:edupals/features/challenge/presentation/view/components/daily_challenge_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyChallengeView extends GetView<DailyChallengeController> {
  const DailyChallengeView({super.key});

  Widget get challengeBody {
    return Obx(() {
      switch (controller.viewState) {
        case ViewState.success:
          return Expanded(
              child: DailyChallengeList(
            challengeList: controller.challengeList?.toList(),
          ));
        case ViewState.noData:
          return const NoDataView(
            message: "There is no challenge for you today.",
          );
        default:
          return const LoadingView();
      }
    });
  }

  Widget challengeList(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ChallengeTopBar()
              .padding(const EdgeInsets.only(bottom: AppValues.double20)),
          challengeBody,
        ],
      ).padding(const EdgeInsets.all(AppValues.double10)).addBackgroundImage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => controller.challengeList?.isEmpty == true
            ? const NoDataView(
                message: "There is no challenge for you today...")
            : Expanded(child: challengeList(context)))
      ],
    ).scaffoldWrapper();
  }
}
