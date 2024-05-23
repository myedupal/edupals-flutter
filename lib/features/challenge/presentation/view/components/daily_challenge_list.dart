import 'package:edupals/core/extensions/context_extensions.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/domain/model/challenge.dart';
import 'package:edupals/features/challenge/domain/model/challenge_argument.dart';
import 'package:edupals/features/challenge/presentation/view/components/challenge_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyChallengeList extends StatelessWidget {
  const DailyChallengeList({
    super.key,
    this.challengeList,
    this.shrinkWrap = false,
  });

  final List<Challenge>? challengeList;
  final bool shrinkWrap;

  int getAxisCount(BuildContext context) {
    int? count = 3;
    if (context.isPhone) {
      count = 1;
    } else if (context.isPhonePortrait) {
      count = 2;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: AppValues.double10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getAxisCount(context),
          childAspectRatio: 2,
          crossAxisSpacing: AppValues.double10,
          mainAxisSpacing: AppValues.double10),
      itemBuilder: (_, index) {
        final Challenge? challenge = challengeList?[index];
        return ChallengeCard(
          challenge: challenge,
          onClick: () {
            Get.toNamed(Routes.challengeDetails,
                arguments: ChallengeArgument(
                    challengeId: challenge?.id, pageTitle: "Daily Challenge"));
          },
        );
      },
      itemCount: challengeList?.length,
    );
  }
}
