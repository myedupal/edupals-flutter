import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/extensions/context_extensions.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/dashboard/presentation/view/components/challenge_banner.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/features/dashboard/presentation/view/components/daily_challenge_report.dart';
import 'package:edupals/features/dashboard/presentation/view/components/mcq_report.dart';
import 'package:edupals/features/dashboard/presentation/view/components/points_breakdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends GetView<MainController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ChallengeBanner(),
              [
                Expanded(
                    flex: context.isPhonePortrait ? 0 : 8,
                    child: Column(
                      children: [
                        const DailyChallengeReport(),
                        const MCQReport().padding(
                            const EdgeInsets.only(top: AppValues.double10))
                      ],
                    )),
                const SizedBox(
                  width: AppValues.double10,
                  height: AppValues.double10,
                ),
                Expanded(
                    flex: context.isPhonePortrait ? 0 : 3,
                    child: const SizedBox(
                      width: double.infinity,
                      child: PointsBreakdown(),
                    ))
              ]
                  .rowToColumn(
                      isActive: context.isPhonePortrait,
                      rowCrossAlignment: CrossAxisAlignment.start)
                  .padding(
                      const EdgeInsets.symmetric(vertical: AppValues.double10))
            ],
          )
        ],
      );
}
