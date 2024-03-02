import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/question-bank/view/componenets/questions_list_top_bar.dart';
import 'package:edupals/features/question-bank/view/componenets/treding_column.dart';
import 'package:flutter/material.dart';

class QuestionsListView extends StatelessWidget {
  const QuestionsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const QuestionsListTopBar(),
        Row(
          children: [
            Expanded(
                flex: 3,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        const TrendingColumn(
                          percentage: 50,
                        ).padding(
                            const EdgeInsets.only(bottom: AppValues.double30)),
                      ],
                    ).padding(const EdgeInsets.symmetric(
                        horizontal: AppValues.double10,
                        vertical: AppValues.double20)),
                  ],
                )),
            Expanded(flex: 8, child: Container())
          ],
        )
      ],
    ).padding(const EdgeInsets.all(AppValues.double10)).scaffoldWrapper();
  }
}
