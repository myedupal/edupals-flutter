import 'package:edupals/core/base/key_value.dart';
import 'package:edupals/core/components/selection_input.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/question-bank/view/componenets/treding_column.dart';
import 'package:flutter/material.dart';

class QuestionBankView extends StatelessWidget {
  const QuestionBankView({super.key});

  Widget get filterBody => Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: SelectionInput(
                label: "Revision Type",
                data: [KeyValue(label: "Yearly")],
              ).padding(const EdgeInsets.only(right: AppValues.double15))),
              Expanded(
                  child: SelectionInput(
                label: "Subject",
                data: [KeyValue(label: "Mathematics")],
              ))
            ],
          ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
          Row(
            children: [
              Expanded(
                  child: const SelectionInput(
                label: "Paper",
              ).padding(const EdgeInsets.only(right: AppValues.double15))),
              const Expanded(
                  child: SelectionInput(
                label: "Season",
              ))
            ],
          ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
          SelectionInput(
            label: "Chapters",
            data: [
              KeyValue(label: "Arithematics"),
              KeyValue(label: "Polynomial"),
              KeyValue(label: "Algebra")
            ],
          ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
          SelectionInput(
            label: "Years",
            data: [KeyValue(label: "2020"), KeyValue(label: "2021")],
          )
        ],
      ).padding(const EdgeInsets.only(top: AppValues.double20));

  Widget get trendingSection => ListView(shrinkWrap: true, children: [
        Text(
          "Trending Yearly",
          style: MyTextStyle.xl.bold,
        ),
        Column(
          children: [
            const TrendingColumn(
              percentage: 50,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            const TrendingColumn(
              percentage: 30,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            const TrendingColumn(
              percentage: 10,
            ),
          ],
        ).padding(const EdgeInsets.symmetric(vertical: AppValues.double20)),
        Text(
          "Trending Topical",
          style: MyTextStyle.xl.bold,
        ),
        Column(
          children: [
            const TrendingColumn(
              percentage: 30,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            const TrendingColumn(
              percentage: 10,
            ),
          ],
        ).padding(const EdgeInsets.symmetric(vertical: AppValues.double20)),
      ]);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Question Bank",
                  style: MyTextStyle.xl1.bold,
                ),
                filterBody
              ],
            ).padding(const EdgeInsets.only(right: AppValues.double40))),
        Flexible(flex: 4, child: trendingSection)
      ],
    ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double20));
  }
}
