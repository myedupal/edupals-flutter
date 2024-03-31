import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/routes/routing.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/question-bank/presentation/controller/question_bank_controller.dart';
import 'package:edupals/features/question-bank/presentation/view/components/question_filter_segment.dart';
import 'package:edupals/features/question-bank/presentation/view/components/treding_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionBankView extends GetView<QuestionBankController> {
  const QuestionBankView({super.key});

  Widget get filterBody => QuestionFilterSegment(
      controllerTag: "question-bank",
      emitData: (value) {
        if (value != null) {
          Get.toNamed(Routes.questionsList, arguments: value);
        }
      });

  Widget get trendingSection => ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              "Trending Yearly",
              style: MyTextStyle.xl.bold,
            ),
            Column(
              children: [
                for (int i = 0; i < 2; i++)
                  const TrendingColumn(
                    withProgress: false,
                    title: "Mathematics",
                    value: "3 Chapters",
                    subvalue: "From 2020 - 2023",
                  ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
              ],
            ).padding(const EdgeInsets.symmetric(vertical: AppValues.double20)),
            Text(
              "Trending Topical",
              style: MyTextStyle.xl.bold,
            ),
            Column(
              children: [
                for (int i = 0; i < 3; i++)
                  const TrendingColumn(
                    percentage: 20,
                    title: "Sociology",
                    value: "4 Chapters",
                    subvalue: "From 2019 - 2021",
                  ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
              ],
            ).padding(const EdgeInsets.symmetric(vertical: AppValues.double20)),
          ]);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<QuestionBankController>(() => QuestionBankController());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Questions Bank",
                  style: MyTextStyle.xl1.bold,
                ),
                filterBody,
              ],
            ).padding(const EdgeInsets.only(right: AppValues.double40))),
        Flexible(flex: 4, child: trendingSection)
      ],
    ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double20));
  }
}
