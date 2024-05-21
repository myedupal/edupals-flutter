import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/dashboard/presentation/controller/dashborad_controller.dart';
import 'package:edupals/features/dashboard/presentation/view/components/dashboard_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MCQReport extends GetView<DashboardController> {
  const MCQReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final report = controller.mcqReport.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MCQs Reports",
            style: MyTextStyle.l.bold,
          ),
          [
            Expanded(
                flex: context.isPhone ? 0 : 1,
                child: Row(
                  children: [
                    DashboardColumn(
                        title: "Average Time",
                        childValue: "${report?.getParsedAverageTime}"),
                    DashboardColumn(
                        title: "Total correct question",
                        childValue: "${report?.getTotalCorrectQuestions}"),
                  ],
                )),
            if (context.isPhone)
              const SizedBox(
                height: AppValues.double10,
              ),
            Expanded(
                flex: context.isPhone ? 0 : 1,
                child: Row(
                  children: [
                    DashboardColumn(
                        title: "Strength",
                        childValue: "${report?.strengthSubject}"),
                    DashboardColumn(
                        title: "Weakness",
                        childValue: "${report?.weaknessSubject}"),
                  ],
                ))
          ]
              .rowToColumn(isActive: context.isPhone)
              .padding(const EdgeInsets.only(top: AppValues.double20)),
        ],
      ).capsulise(
          radius: 20,
          color: AppColors.gray100,
          padding: const EdgeInsets.all(AppValues.double20));
    });
  }
}
