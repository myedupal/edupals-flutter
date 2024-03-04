import 'package:edupals/core/components/base_accordion.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/question-bank/presentation/view/components/questions_list_top_bar.dart';
import 'package:edupals/features/question-bank/presentation/view/components/treding_column.dart';
import 'package:flutter/material.dart';

class QuestionsListView extends StatelessWidget {
  const QuestionsListView({super.key});

  Widget get actionList => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ImageAssetView(
            fileName: AppAssets.flag,
            width: AppValues.double15,
            height: AppValues.double15,
          )
              .capsulise(
                  radius: 100,
                  color: AppColors.accent100,
                  padding: const EdgeInsets.all(AppValues.double15))
              .padding(const EdgeInsets.only(bottom: AppValues.double15)),
          const ImageAssetView(
            fileName: AppAssets.flashCard,
            width: AppValues.double15,
            height: AppValues.double15,
            color: AppColors.accent500,
          ).capsulise(
              radius: 100,
              color: AppColors.accent100,
              padding: const EdgeInsets.all(AppValues.double15))
        ],
      );

  Widget get questionDetails => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Q2 2010 0606-s",
            style: MyTextStyle.xxl.bold,
          ),
          Expanded(
              child: ListView(shrinkWrap: true, children: [
            Column(
              children: [
                for (int i = 0; i < 5; i++)
                  const ImageAssetView(fileName: AppAssets.mockQuestion)
                      .padding(
                          const EdgeInsets.only(bottom: AppValues.double50))
              ],
            ).padding(const EdgeInsets.symmetric(vertical: AppValues.double20))
          ]))
        ],
      ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double40));

  Widget get chapterList => ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Column(
            children: [
              const TrendingColumn(
                percentage: 50,
              ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
              BaseAccordion(
                title: "Chapter 1",
                child: Row(
                  children: [
                    Text(
                      "Q1",
                      style: MyTextStyle.xs.bold.c(AppColors.white),
                    ).capsulise(
                        color: AppColors.accent500,
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppValues.double8,
                            vertical: AppValues.double6)),
                    Text(
                      "2010 0606-s",
                      style: MyTextStyle.s.bold.c(AppColors.accent500),
                    ).padding(const EdgeInsets.only(left: AppValues.double10))
                  ],
                ).capsulise(
                    radius: 15,
                    color: AppColors.gray100,
                    padding: const EdgeInsets.symmetric(
                        vertical: AppValues.double15,
                        horizontal: AppValues.double15)),
              ),
              const BaseAccordion(
                title: "Chapter 1",
              )
            ],
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const QuestionsListTopBar(),
        Expanded(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: chapterList),
            Expanded(flex: 8, child: questionDetails),
            actionList
          ],
        ).padding(const EdgeInsets.symmetric(
                horizontal: AppValues.double10, vertical: AppValues.double25)))
      ],
    ).padding(const EdgeInsets.all(AppValues.double10)).scaffoldWrapper();
  }
}
